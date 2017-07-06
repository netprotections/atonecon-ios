//
//  PaymentViewController.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 6/28/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import UIKit
import WebKit

internal protocol PaymentViewControllerDelegate: class {
    func paymentViewController(_ paymentViewController: PaymentViewController, needsPerformAction action: AtoneConScriptsHandler.Action)
}

final internal class PaymentViewController: UIViewController {

    // MARK: - Properties
    private var webView: WKWebView!
    fileprivate var indicator: UIActivityIndicatorView!
    var atoneConScriptHandle: AtoneConScriptsHandler!
    weak var delegate: PaymentViewControllerDelegate?

    // MARK: - Cycle Life
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        setupIndicator()
    }

    // MARK: - Private Functions
    private func setupWebView() {
        let configuration = WKWebViewConfiguration()
        configuration.userContentController.addUserScript(userScript())
        webView = WKWebView(frame: view.bounds, configuration: configuration)
        webView.backgroundColor = Define.Color.blackAlpha90
        view.addSubview(webView)
        let urlRequest = URLRequest(url: htmlURL())
        webView.load(urlRequest)
        webView.navigationDelegate = self

        atoneConScriptHandle = AtoneConScriptsHandler()
        atoneConScriptHandle.delegate = self
    }

    private func setupIndicator() {
        indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.center = view.center
        view.addSubview(indicator)
    }

    private func htmlURL() -> URL {
        return url(forResource: "atone", withExtension: "html")
    }

    private func userScript() -> WKUserScript {
        do {
            let url = self.url(forResource: "atone", withExtension: "js")
            let source = try String(contentsOf: url, encoding: .utf8)
            let userScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
            return userScript
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    private func url(forResource name: String?, withExtension ext: String?) -> URL {
        let bundle = Bundle(for: PaymentViewController.self)
        guard let url = bundle.url(forResource: name, withExtension: ext, subdirectory: "www") else {
            fatalError("File Not Found")
        }
        return url
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
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let this = self else { return }
            this.indicator.stopAnimating()
            this.startAtone()
        }
    }
}

extension PaymentViewController: AtoneConScriptsHandlerDelegate {
    func atoneScriptsHandler(_ atoneConScriptsHandler: AtoneConScriptsHandler, needsPerformAction action: AtoneConScriptsHandler.Action) {
        switch action {
        case .dismiss:
            dismiss(animated: true, completion: nil)
        default:
            delegate?.paymentViewController(self, needsPerformAction: action)
        }
    }
}
