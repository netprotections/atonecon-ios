//
//  SessionTest.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 8/18/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import XCTest
@testable import AtoneCon

final class SessionTests: XCTestCase {

    override func tearDown() {
        super.tearDown()
        Session.shared.clearCredential()
    }

    func testLoadCredentialShouldReturnInvalidCredentialWhenAuthTokenIsNil() {
        // When
        Session.shared.credential = Session.Credential(authToken: nil)
        Session.shared.loadCredential()

        // Then
        XCTAssertFalse(Session.shared.credential.isValid)
    }

    func testLoadCredentialShouldReturnStringWhenValueCredentialIsNotEmpty() {
        // When
        Session.shared.credential = Session.Credential(authToken: "tk_23adh123bvnjKhds")
        Session.shared.loadCredential()

        // Then
        XCTAssertTrue(Session.shared.credential.isValid)
    }

    func testLoadCredentialShouldReturnEmptyStringWhenValueCredentialIsEmptyString() {
        // When
        Session.shared.credential = Session.Credential(authToken: "")
        Session.shared.loadCredential()

        // Then
        XCTAssertFalse(Session.shared.credential.isValid)
    }

    func testClearCredentialShouldReturnEmptyWhenRemoveCredential() {
        // When
        Session.shared.credential = Session.Credential(authToken: "tk_23adh123bvnjKhds")
        Session.shared.clearCredential()

        // Then
        XCTAssertFalse(Session.shared.credential.isValid)
    }
}
