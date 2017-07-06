//
//  AtonneConScriptHandler.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 7/6/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation
import WebKit

internal protocol AtoneConScriptsHandlerDelegate: class {
    func atoneScriptsHandler(_ atoneConScriptsHandler: AtoneConScriptsHandler, needsPerformAction action: AtoneConScriptsHandler.Action)
}

private struct MessageName {
    static let authenticated = "authenticated"
    static let cancelled = "cancelled"
    static let failed = "failed"
    static let succeeded = "succeeded"
    static let dismiss = "dismiss"
}

internal final class AtoneConScriptsHandler: NSObject {

    private var webView: WKWebView!
    internal weak var delegate: AtoneConScriptsHandlerDelegate?
    private let events: [String] = [MessageName.authenticated, MessageName.cancelled, MessageName.failed, MessageName.succeeded, MessageName.dismiss]

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

extension AtoneConScriptsHandler {
    internal enum Action {
        case authenticated(String?)
        case canceled
        case succeeded(Any)
        case failed(Any)
        case dismiss
    }
}

extension AtoneConScriptsHandler: WKScriptMessageHandler {
    internal func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        var action: Action!
        switch message.name {
        case MessageName.authenticated:
            action = Action.authenticated(message.body as? String)
        case MessageName.cancelled:
            action = Action.canceled
        case MessageName.failed:
            action = Action.failed(message.body)
        case MessageName.succeeded:
            action = Action.succeeded(message.body)
        case MessageName.dismiss:
            action = Action.dismiss
        default:
            return
        }
        delegate?.atoneScriptsHandler(self, needsPerformAction: action)
    }
}
