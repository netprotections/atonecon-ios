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
    func scriptsHandler(_ scriptsHandler: ScriptsHandler, didReceiveEvent event: ScriptsHandler.Event)
}

private enum MessageName {
    static let authenticated = "authenticated"
    static let cancelled = "cancelled"
    static let failed = "failed"
    static let succeeded = "succeeded"
}

internal final class ScriptsHandler: NSObject {

    private var webView: WKWebView!
    internal weak var delegate: ScriptsHandlerDelegate?
    private let events: [String] = [MessageName.authenticated, MessageName.cancelled, MessageName.failed, MessageName.succeeded]

    internal init(forWebView webView: WKWebView) {
        self.webView = webView
    }

    internal func addEvents() {
        let controller = webView.configuration.userContentController
        for event in events {
            controller.add(self, name: event)
        }
    }
}

extension ScriptsHandler {
    internal enum Event {
        case authenticated(String?)
        case canceled
        case succeeded(Any)
        case failed(Any)
    }
}

extension ScriptsHandler: WKScriptMessageHandler {
    internal func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        var event: Event!
        switch message.name {
        case MessageName.authenticated:
            print(message.body)
            event = Event.authenticated(message.body as? String)
        case MessageName.cancelled:
            print(message.body)
            event = Event.canceled
        case MessageName.failed:
            print(message.body)
            event = Event.failed(message.body)
        case MessageName.succeeded:
            print(message.body)
            event = Event.succeeded(message.body)
        default: return
        }
        delegate?.scriptsHandler(self, didReceiveEvent: event)
    }
}
