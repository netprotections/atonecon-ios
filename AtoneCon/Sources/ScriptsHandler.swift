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

private enum MessageName: String {
    case authenticated
    case cancelled
    case failed
    case succeeded
}

internal final class ScriptsHandler: NSObject {

    private var webView: WKWebView!
    internal weak var delegate: ScriptsHandlerDelegate?
    private let events: [String] = [MessageName.authenticated.rawValue, MessageName.cancelled.rawValue, MessageName.failed.rawValue, MessageName.succeeded.rawValue]

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
        guard let nameMessage = MessageName(rawValue: message.name) else { return }
        switch nameMessage {
        case .authenticated :
            // TODO: save authentoken
            event = Event.authenticated(message.body as? String)
        case .cancelled:
            // TODO: get respone
            event = Event.canceled
        case .failed:
            // TODO: get respone
            event = Event.failed(message.body)
        case .succeeded:
            // TODO: get respone
            event = Event.succeeded(message.body)
        }
        delegate?.scriptsHandler(self, didReceiveEvent: event)
    }
}
