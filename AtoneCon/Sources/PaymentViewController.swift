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

    private var webView: WKWebView!

    private var htmlContent: String {
        let bundle = Bundle(for: PaymentViewController.self)
        guard let url = bundle.url(forResource: "atone", withExtension: "html") else {
            fatalError("File Not Found")
        }
        do {
            let string = try String(contentsOf: url)
            return string
        } catch {
            fatalError("File Not Found")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }

    private func setupWebView() {
        webView = WKWebView(frame: view.bounds)
        view.addSubview(webView)
        webView.loadHTMLString(htmlContent, baseURL: nil)
    }
}
