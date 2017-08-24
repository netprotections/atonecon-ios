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

final class ScriptHandlerTest: XCTestCase {
    func testScriptEventNameShouldReturnCancelledWhenInitializedCancelledEvent() {
        // When
        let cancelledEvent = ScriptEvent.cancelled

        // Then
        XCTAssertEqual(cancelledEvent.messageName.name, "cancelled")
    }

    func testScriptEventNameShouldReturnSucceededWhenInitializedSucceededEvent() {
        // When
        let succeededEvent = ScriptEvent.succeeded(nil)

        // Then
        XCTAssertEqual(succeededEvent.messageName.name, "succeeded")
    }

    func testScriptEventNameShouldReturnFailedWhenInitializedFailedEvent() {
        // When 
        let failedEvent = ScriptEvent.failed(nil)

        // Then
        XCTAssertEqual(failedEvent.messageName.name, "failed")
    }

    func testScriptEventNameShouldReturnAuthenticatedWhenInitializedAuthenticatedEvent() {
        // When
        let authenticatedEvent = ScriptEvent.authenticated(nil)

        // Then
        XCTAssertEqual(authenticatedEvent.messageName.name, "authenticated")
    }

    func testInitShouldReturnScripHandleObjectWhenInitialized() {
        // When
        let configuration = WKWebViewConfiguration()
        let webView = WKWebView(frame: UIScreen.main.bounds, configuration: configuration)
        let scriptHandler = ScriptHandler(forWebView: webView)

        // Then
        XCTAssertNotNil(scriptHandler.webView)
    }
}
