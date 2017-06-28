//
//  AtoneWebKitViewController.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 6/28/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import UIKit
import WebKit

public class AtoneWebKitViewController: UIViewController {

    private var wkWebView: WKWebView!

    override public func viewDidLoad() {
        super.viewDidLoad()
        setUpWKWebView()
        loadWebView()
    }

    private func setUpWKWebView() {
        wkWebView = WKWebView(frame: view.bounds)
        view.addSubview(wkWebView)
    }

    private func loadWebView() {
        // TODO: Load the html file from local resource folder
        guard let url = URL(string: "https://www.google.com.vn/") else { return }
        let urlRequest = URLRequest(url: url)
        wkWebView.load(urlRequest)
    }

    // MARK: - Action
}
