//
//  Script.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 7/21/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation

extension Define {
    internal struct Scripts {
        static let atoneJS =
            "\nAtone.config({" +
                "pre_token: \"%@\"," +
                "pub_key: \"%@\"," +
                "payment: data," +
                "authenticated: function(authentication_token) { " +
                    "window.webkit.messageHandlers.authenticated.postMessage(authentication_token);" +
                "}," +
                "cancelled: function() { " +
                    "window.webkit.messageHandlers.cancelled.postMessage(\'ングで呼び出し\');" +
                "}," +
                "failed: function(response) { " +
                    "window.webkit.messageHandlers.failed.postMessage(response);" +
                "}," +
                "succeeded: function(response) { " +
                    "window.webkit.messageHandlers.succeeded.postMessage(response);" +
                "}," +
                "error: function(name, message, errors) { " +
                    "var response = {name: name, message: message, errors: errors};" +
                    "window.webkit.messageHandlers.failed.postMessage(response);" +
                "}" +
            "});" +
            "function startAtone() { Atone.start();}\n"

        static let atoneHTML =
            "<!DOCTYPE html>" +
            "<html lang=\"ja\">" +
                "<head>" +
                    "<meta charset=\"UTF-8\">" +
                    "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">" +
                    "<meta name=\"viewport\" content=\"initial-scale=%@,maximum-scale=1.0,width=device-width,user-scalable=1\">" +
                    "<link rel=\"stylesheet\" href=\"https://www.w3schools.com/w3css/4/w3mobile.css\">" +
                    "<script src=\"https://it-auth.a-to-ne.jp/v1/atone.js\">" +
                    "</script>" +
                "</head>" +
                "<title>ページタイトル</title>" +
                "<body style=\"background-color:rgba(0, 0, 0, 0.3);\">" +
                "</body>" +
            "</html>"
    }
}
