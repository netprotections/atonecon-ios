//
//  ScriptHandler.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 7/6/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation
import WebKit

internal protocol ScriptsHandlerDelegate: class {
    func scriptsHandler(_ scriptsHandler: ScriptsHandler, needsPerformAction action: ScriptsHandler.Action)
}

private struct MessageName {
    static let authenticated = "authenticated"
    static let cancelled = "cancelled"
    static let failed = "failed"
    static let succeeded = "succeeded"
}

internal final class ScriptsHandler: NSObject {

    private var webView: WKWebView!
    internal weak var delegate: ScriptsHandlerDelegate?
    private let events: [String] = [MessageName.authenticated, MessageName.cancelled, MessageName.failed, MessageName.succeeded]

    init(forWebView webView: WKWebView) {
        self.webView = webView
    }

    internal func eventScript() {
        let controller = webView.configuration.userContentController
        for event in events {
            controller.add(self, name: event)
        }
    }
}

extension ScriptsHandler {
    internal enum Action {
        case authenticated(String?)
        case canceled
        case succeeded(Any)
        case failed(Any)
    }
}

extension ScriptsHandler: WKScriptMessageHandler {
    internal func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        var action: Action!
        switch message.name {
        case MessageName.authenticated:
            print(message.body)
            action = Action.authenticated(message.body as? String)
        case MessageName.cancelled:
            print(message.body)
            action = Action.canceled
        case MessageName.failed:
            print(message.body)
            action = Action.failed(message.body)
        case MessageName.succeeded:
            print(message.body)
            action = Action.succeeded(message.body)
        default: return
        }
        delegate?.scriptsHandler(self, needsPerformAction: action)
    }
}
