//
//  ScriptHandler.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 7/6/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation
import WebKit

internal protocol ScriptHandlerDelegate: class {
    func scriptHandler(_ scriptHandler: ScriptHandler, didReceiveScriptEvent event: ScriptEvent)
}

private enum MessageName: String {
    case authenticated
    case cancelled
    case failed
    case succeeded
}

internal enum ScriptEvent {
    case authenticated(String?)
    case canceled
    case succeeded(Any)
    case failed(Any)
}

internal final class ScriptHandler: NSObject {

    private var webView: WKWebView!
    internal weak var delegate: ScriptHandlerDelegate?
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

extension ScriptHandler: WKScriptMessageHandler {
    internal func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        var event: ScriptEvent!
        guard let scriptEvent = MessageName(rawValue: message.name) else { return }
        switch scriptEvent {
        case .authenticated :
            // TODO: save authentoken
            event = ScriptEvent.authenticated(message.body as? String)
        case .cancelled:
            // TODO: get respone
            event = ScriptEvent.canceled
        case .failed:
            // TODO: get respone
            event = ScriptEvent.failed(message.body)
        case .succeeded:
            // TODO: get respone
            event = ScriptEvent.succeeded(message.body)
        }
        delegate?.scriptHandler(self, didReceiveScriptEvent: event)
    }
}
