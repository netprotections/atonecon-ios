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
    func controller(_ controller: PaymentViewController, didReceiveScriptEvent event: ScriptEvent)
}

final internal class PaymentViewController: UIViewController {

    // MARK: - Properties
    internal var option: AtoneCon.Options?
    private var payment: AtoneCon.Payment?
    private var webView: WKWebView!
    fileprivate var indicator: UIActivityIndicatorView!
    private var scriptHandler: ScriptHandler!
    weak var delegate: PaymentViewControllerDelegate?

    convenience init(payment: AtoneCon.Payment) {
        self.init()
        self.payment = payment
    }

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

    private func htmlURL() -> URL {
        return url(forResource: "atone", withExtension: "html")
    }

    private func userScript() -> WKUserScript {
        guard let jsonString = payment?.toJSONString(prettyPrint: true) else {
            fatalError("don't receive information of payment")
        }
        let handlerScriptString = getHandlerScriptString()
        let paymentScriptString = "var data = " + jsonString
        let userScript = WKUserScript(source: paymentScriptString + handlerScriptString, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        return userScript
    }

    private func getHandlerScriptString() -> String {
        var publicKey = ""
        if let option = option {
            publicKey = option.publicKey
        }
        var preToken = ""
        if let token = UserDefaults.standard.string(forKey: Define.String.tokenKey) {
            preToken = token
        }
        let handlerScriptString = "\nAtone.config({\n" +
            "pre_token: \"" + preToken + "\",\n" +
            "pub_key: \"" + publicKey + "\",\n" +
            "payment: data,\n" +
            "authenticated: function(authentication_token) {\n" +
                "window.webkit.messageHandlers.authenticated.postMessage(authentication_token);\n" +
            "},\n" +
            "cancelled: function() {\n" +
                "window.webkit.messageHandlers.cancelled.postMessage(\'ングで呼び出し\');\n" +
            "},\n" +
            "failed: function(response) {\n" +
                "window.webkit.messageHandlers.failed.postMessage(response);\n" +
            "},\n" +
            "succeeded: function(response) {\n" +
                "window.webkit.messageHandlers.succeeded.postMessage(response);\n" +
            "}\n" +
            "});\n" +
            "function startAtone() {Atone.start();}\n"
        return handlerScriptString
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

    internal func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let this = self else { return }
            this.indicator.stopAnimating()
            this.startAtone()
        }
    }
}

extension PaymentViewController: ScriptHandlerDelegate {
    func scriptHandler(_ scriptHandler: ScriptHandler, didReceiveScriptEvent event: ScriptEvent) {
        delegate?.controller(self, didReceiveScriptEvent: event)
    }
}
