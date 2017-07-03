//
//  AtoneWebKitViewController.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 6/28/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import UIKit
import WebKit

internal class PaymentViewController: UIViewController {

    private var webView: WKWebView!

    override internal func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        loadWebView()
    }

    private func setupWebView() {
        webView = WKWebView(frame: view.bounds)
        view.addSubview(webView)
    }

    private func loadWebView() {
        // TODO: Load the html file from local resource folder
        guard let url = URL(string: "https://www.google.com.vn/") else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
}
