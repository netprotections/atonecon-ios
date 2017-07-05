//
//  PaymentViewController.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 6/28/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import UIKit
import WebKit

final internal class PaymentViewController: UIViewController {

    // MARK: - Properties
    private var webView: WKWebView!

    // MARK: - Cycle Life
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }

    // MARK: - Private Functions
    private func setupWebView() {
        webView = WKWebView(frame: view.bounds)
        view.addSubview(webView)
        webView.loadHTMLString(htmlContent(), baseURL: nil)
        webView.navigationDelegate = self
        injectScripts()
    }

    private func injectScripts() {
        let controller = webView.configuration.userContentController
        controller.addUserScript(userScript())
    }

    private func htmlContent() -> String {
        do {
            let url = self.url(forResource: "atone", withExtension: "html")
            let string = try String(contentsOf: url)
            return string
        } catch {
            fatalError(error.localizedDescription)
        }
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
    fileprivate func evaluateScript() {
        // TODO: Implement completion Handler
        webView.evaluateJavaScript("startAtone();") { [weak self](_, error) in
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
        evaluateScript()
    }
}
