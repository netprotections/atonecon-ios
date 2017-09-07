//
//  PaymentViewController.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 6/28/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import UIKit
import WebKit
import SAMKeychain

internal protocol PaymentViewControllerDelegate: class {
    func controller(_ controller: PaymentViewController, didReceiveScriptEvent event: ScriptEvent)
}

final internal class PaymentViewController: UIViewController {

    // MARK: - Delegate
    weak var delegate: PaymentViewControllerDelegate?

    // MARK: - Properties
    private var payment: AtoneCon.Payment?
    internal var webView: WKWebView!
    internal var indicator: UIActivityIndicatorView!
    internal var scriptHandler: ScriptHandler!
    fileprivate var closeButton: UIButton!

    func atoneHTML() throws -> String {
        var atoneJSURL = ""
        guard let options = AtoneCon.shared.options else {
            let error: [String: Any] = [Define.String.Key.title: Define.String.options,
                                        Define.String.Key.message: Define.String.Error.options]
            throw AtoneConError.option(error)
        }
        switch options.environment {
        case .development:
            atoneJSURL = "https://it-auth.a-to-ne.jp/v1/atone.js"
        case .production:
            atoneJSURL = "https://auth.atone.be/v1/atone.js"
        case .staging:
            atoneJSURL = "https://it-auth.a-to-ne.jp/v1/atone.js"
        }
        let publicKey = options.publicKey
        var preToken = ""
        if let accessToken = Session.shared.credential.authToken {
            preToken = accessToken
        }
        let handlerScript = String(format: Define.Scripts.atoneJS, preToken, publicKey)
        guard let paymentJSON = payment?.toJSONString(prettyPrint: true) else {
            let error: [String: Any] = [Define.String.Key.title: Define.String.paymentInfo,
                                        Define.String.Key.message: Define.String.Error.payment]
            throw AtoneConError.payment(error)
        }
        let paymentScript = "var data = " + paymentJSON

        let deviceScale = Define.Helper.Ratio.horizontal
        let atoneHTML = String(format: Define.Scripts.atoneHTML, "\(deviceScale)", atoneJSURL, paymentScript, handlerScript)
        return atoneHTML
    }

    convenience init(payment: AtoneCon.Payment) {
        self.init()
        self.payment = payment
    }

    // MARK: - Cycle Life
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        setupIndicator()
        setupCloseButton()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }

    // MARK: - Private Functions
    private func setupWebView() {
        do {
            webView = WKWebView(frame: view.bounds)
            webView.backgroundColor = Define.Color.blackAlpha90
            webView.contentMode = .scaleToFill
            webView.autoresizingMask = .flexibleWidth
            view.addSubview(webView)
            let html = try atoneHTML()
            webView.loadHTMLString(html, baseURL: nil)
            webView.navigationDelegate = self
            webView.uiDelegate = self
            scriptHandler = ScriptHandler(forWebView: webView)
            scriptHandler.addEvents()
            scriptHandler.delegate = self
        } catch AtoneConError.payment(let error) {
            let event = ScriptEvent.failed(error)
            delegate?.controller(self, didReceiveScriptEvent: event)
        } catch AtoneConError.option(let error) {
            let event = ScriptEvent.failed(error)
            delegate?.controller(self, didReceiveScriptEvent: event)
        } catch {
            let error: [String: Any] = [Define.String.Key.message: Define.String.Error.undefine]
            let event = ScriptEvent.failed(error)
            delegate?.controller(self, didReceiveScriptEvent: event)
        }
    }

    private func setupCloseButton() {
        // Client will supply icon and size for button.
        let width: CGFloat = 36 * Define.Helper.Ratio.horizontal
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let edgeInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 5)
        let frame = CGRect(x: view.frame.width - width - edgeInset.right, y: edgeInset.top + statusBarHeight, width: width, height: width)
        closeButton = UIButton(frame: frame)
        let imageCloseButton = UIImage(named: Define.String.Image.close, in: Bundle.current, compatibleWith: nil)
        closeButton.setBackgroundImage(imageCloseButton, for: .normal)
        closeButton.addTarget(self, action: #selector(closeWebView), for: .touchUpInside)
        view.addSubview(closeButton)
    }

    private func setupIndicator() {
        indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.center = view.center
        view.addSubview(indicator)
    }

    @objc private func closeWebView() {
        let alert = UIAlertController(title: Define.String.quitPayment, message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: Define.String.cancel, style: .cancel, handler: nil)
        let ok = UIAlertAction(title: Define.String.okay, style: .default, handler: { _ in
            AtoneCon.shared.dismiss()
        })
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - WKNavigationDelegate
extension PaymentViewController: WKNavigationDelegate {
    internal func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else {
            decisionHandler(.cancel)
            return
        }
        if url.absoluteString.contains(Define.String.Key.loading) {
            indicator.stopAnimating()
            closeButton.isHidden = true
        }
        decisionHandler(.allow)
    }
}

extension PaymentViewController: WKUIDelegate {
    internal func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if let url = navigationAction.request.url {
            UIApplication.shared.openURL(url)
        }
        return nil
    }
}

// MARK: - ScriptHandlerDelegate
extension PaymentViewController: ScriptHandlerDelegate {
    func scriptHandler(_ scriptHandler: ScriptHandler, didReceiveScriptEvent event: ScriptEvent) {
        delegate?.controller(self, didReceiveScriptEvent: event)
    }
}
