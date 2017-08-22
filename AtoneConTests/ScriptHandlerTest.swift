//
//  ScriptHandlerTest.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 8/21/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import XCTest
import WebKit
@testable import AtoneCon

class ScriptHandlerTest: XCTestCase {
    func testScriptEvent() {
        // When
        let cancelledEvent = ScriptEvent.cancelled
        let succeededEvent = ScriptEvent.succeeded(nil)
        let failedEvent = ScriptEvent.failed(nil)
        let authenticatedEvent = ScriptEvent.authenticated(nil)

        // Then
        XCTAssertEqual(cancelledEvent.messageName.name, "cancelled")
        XCTAssertEqual(succeededEvent.messageName.name, "succeeded")
        XCTAssertEqual(failedEvent.messageName.name, "failed")
        XCTAssertEqual(authenticatedEvent.messageName.name, "authenticated")
    }

    func testInit() {
        // When
        let configuration = WKWebViewConfiguration()
        let webView = WKWebView(frame: UIScreen.main.bounds, configuration: configuration)
        let scriptHandler = ScriptHandler(forWebView: webView)

        // Then
        XCTAssertNotNil(scriptHandler.webView)
    }

    func testAddEvents() {
    }
}
