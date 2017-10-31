//
//  ScriptHandler.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 7/6/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation
import WebKit
import SAMKeychain

internal protocol ScriptHandlerDelegate: class {
    func scriptHandler(_ scriptHandler: ScriptHandler, didReceiveScriptEvent event: ScriptEvent)
}

internal enum Message: String {
    case authenticated
    case cancelled
    case succeeded
    case failed

    internal var name: String {
        return rawValue
    }
}

internal enum ScriptEvent {
    case authenticated(String?, String?)
    case cancelled
    case succeeded([String: Any]?)
    case failed([String: Any]?)

    internal var messageName: Message {
        switch self {
        case .authenticated(_):
            return .authenticated
        case .cancelled:
            return .cancelled
        case .failed(_):
            return .failed
        case .succeeded(_):
            return .succeeded
        }
    }
}

internal final class ScriptHandler: NSObject {

    internal var webView: WKWebView!
    internal weak var delegate: ScriptHandlerDelegate?
    internal let messages: [Message] = [.authenticated, .cancelled, .failed, .succeeded]

    internal init(forWebView webView: WKWebView) {
        self.webView = webView
    }

    internal func addEvents() {
        let controller = webView.configuration.userContentController
        for message in messages {
            controller.add(self, name: message.name)
        }
    }
}

extension ScriptHandler: WKScriptMessageHandler {
    internal func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let event: ScriptEvent
        guard let messageName = Message(rawValue: message.name) else {
            let error: [String:Any] = [Define.String.Key.title: Define.String.options,
                                       Define.String.Key.message: "no handle for event \(message.name)"]
            let event = ScriptEvent.failed(error)
            delegate?.scriptHandler(self, didReceiveScriptEvent: event)
            return
        }
        switch messageName {
        case .authenticated :
            guard let response = message.body as? [String:Any] else { return }
            let token = response["authentication"] as? String
            let userNo = response["user_no"] as? String
            Session.shared.credential = Session.Credential(authToken: token)
            event = ScriptEvent.authenticated(token, userNo)
        case .cancelled:
            event = ScriptEvent.cancelled
        case .failed:
            event = ScriptEvent.failed(message.body as? [String: Any])
        case .succeeded:
            event = ScriptEvent.succeeded(message.body as? [String: Any])
        }
        delegate?.scriptHandler(self, didReceiveScriptEvent: event)
    }
}
