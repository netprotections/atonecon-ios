//
//  AtoneWebKitViewController.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 6/28/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import UIKit
import WebKit

public class AtoneViewController: UIViewController {

    private var webView: WKWebView!

    override public func viewDidLoad() {
        super.viewDidLoad()
        setUpWebView()
        loadWebView()
    }

    private func setUpWebView() {
        webView = WKWebView(frame: view.bounds)
        view.addSubview(webView)
    }

    private func loadWebView() {
        // TODO: Load the html file from local resource folder
        let bundle = Bundle(for: AtoneViewController.self)
        guard let url = bundle.url(forResource: "pageSample", withExtension: "html") else { return }
        print("load url")
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
}
