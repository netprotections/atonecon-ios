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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        // TODO: Dummy Data
        load(path: "https://www.google.com.vn/")
    }

    private func setupWebView() {
        webView = WKWebView(frame: view.bounds)
        view.addSubview(webView)
    }

    private func load(path: String) {
        // TODO: Load the html file from local resource folder
        guard let url = URL(string: path) else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
}
