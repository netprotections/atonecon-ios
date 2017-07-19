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

private enum Message: String {
    case authenticated
    case cancelled
    case succeeded
    case failed

    var name: String {
        return rawValue
    }
}

public enum ScriptEvent {
    case authenticated(String?)
    case cancelled
    case succeeded(Any?)
    case failed(Any?)

    fileprivate var messageName: Message {
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

    private var webView: WKWebView!
    internal weak var delegate: ScriptHandlerDelegate?
    private let messages: [Message] = [.authenticated, .cancelled, .failed, .succeeded]

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
            fatalError("no handle for event \(message.name)")
        }
        switch messageName {
        case .authenticated :
            let token = message.body as? String
            UserDefaults.standard.set(token, forKey: Define.String.tokenKey)
            event = ScriptEvent.authenticated(token)
        case .cancelled:
            event = ScriptEvent.cancelled
        case .failed:
            event = ScriptEvent.failed(message.body)
        case .succeeded:
            event = ScriptEvent.succeeded(message.body)
        }
        delegate?.scriptHandler(self, didReceiveScriptEvent: event)
    }
}
