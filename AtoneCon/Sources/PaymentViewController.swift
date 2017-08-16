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
    fileprivate var webView: WKWebView!
    fileprivate var indicator: UIActivityIndicatorView!
    private var scriptHandler: ScriptHandler!

    private var handlerScript: String {
        let publicKey = AtoneCon.shared.option.publicKey
        var preToken = ""
        if let accessToken = Session.shared.credential.value {
            preToken = accessToken
        }
        let handlerScript = String(format: Define.Scripts.atoneJS, preToken, publicKey)
        return handlerScript
    }

    private var atoneHTML: String {
        let deviceScale = Define.Helper.Ratio.horizontal
        let atoneHTML = String(format: Define.Scripts.atoneHTML, "\(deviceScale)")
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
        setupNavigation()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }

    // MARK: - Private Functions
    private func setupWebView() {
        let configuration = WKWebViewConfiguration()
        configuration.userContentController.addUserScript(userScript())
        webView = WKWebView(frame: view.bounds, configuration: configuration)
        webView.backgroundColor = Define.Color.blackAlpha90
        webView.contentMode = .scaleToFill
        webView.autoresizingMask = .flexibleWidth
        view.addSubview(webView)
        setAutolayoutWebView()
        webView.loadHTMLString(atoneHTML, baseURL: nil)
        webView.navigationDelegate = self
        scriptHandler = ScriptHandler(forWebView: webView)
        scriptHandler.addEvents()
        scriptHandler.delegate = self
    }

    private func setupIndicator() {
        indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.center = view.center
        view.addSubview(indicator)
    }

    private func userScript() -> WKUserScript {
        guard let paymentJSON = payment?.toJSONString(prettyPrint: true) else {
            fatalError("don't receive information of payment")
        }
        let paymentScript = "var data = " + paymentJSON
        let userScript = WKUserScript(source: paymentScript + handlerScript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        return userScript
    }

    // MARK: - Fileprivate Functions
    fileprivate func startAtone() {
        // TODO: Implement completion Handler
        webView.evaluateJavaScript("startAtone()") { [weak self](_, error) in
            guard self != nil else { return }
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - WKNavigationDelegate
extension PaymentViewController: WKNavigationDelegate {

    internal func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let this = self else { return }
            this.indicator.stopAnimating()
            this.startAtone()
        }
    }
}

// MARK: - ScriptHandlerDelegate
extension PaymentViewController: ScriptHandlerDelegate {
    func scriptHandler(_ scriptHandler: ScriptHandler, didReceiveScriptEvent event: ScriptEvent) {
        delegate?.controller(self, didReceiveScriptEvent: event)
    }
}

// MARK: - Setup Navigation 
extension PaymentViewController {
    fileprivate func setupNavigation() {
        let closeButton = UIBarButtonItem(title: Define.Strings.close, style: .plain, target: self, action: #selector(closeWebView))
        navigationItem.rightBarButtonItem = closeButton
    }

    @objc private func closeWebView() {
        AtoneCon.shared.dismissWebview()
    }
}
