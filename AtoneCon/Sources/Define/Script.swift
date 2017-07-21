//
//  Script.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 7/21/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation

extension Define {
    internal struct Script {
        static let handler = "\nAtone.config({ pre_token: \"%@\", pub_key: \"%@\", payment: data, " +
            "authenticated: function(authentication_token) { window.webkit.messageHandlers.authenticated.postMessage(authentication_token);}, " +
            "cancelled: function() { window.webkit.messageHandlers.cancelled.postMessage(\'ングで呼び出し\');}, " +
            "failed: function(response) { window.webkit.messageHandlers.failed.postMessage(response);}, " +
            "succeeded: function(response) { window.webkit.messageHandlers.succeeded.postMessage(response);}});" +
        "function startAtone() {Atone.start();}\n"
    }
}
