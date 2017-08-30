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

    func testLoadCredentialShouldReturnEmptyStringWhenValueCredentialNil() {
        // When
        Session.shared.credential = Session.Credential(value: nil)
        Session.shared.loadCredential()

        // Then
        XCTAssertEqual(Session.shared.credential.value, "")
    }

    func testLoadCredentialShouldReturnStringWhenValueCredentialIsNotEmpty() {
        // When
        Session.shared.credential = Session.Credential(value: "tk_23adh123bvnjKhds")
        Session.shared.loadCredential()

        // Then
        XCTAssertEqual(Session.shared.credential.value, "tk_23adh123bvnjKhds")
    }

    func testLoadCredentialShouldReturnEmptyStringWhenValueCredentialIsEmptyString() {
        // When
        Session.shared.credential = Session.Credential(value: "")
        Session.shared.loadCredential()

        // Then
        XCTAssertEqual(Session.shared.credential.value, "")
    }

    func testClearCredentialShouldReturnEmptyWhenRemoveCredential() {
        // When
        Session.shared.credential = Session.Credential(value: "tk_23adh123bvnjKhds")
        Session.shared.clearCredential()

        // Then
        XCTAssertEqual(Session.shared.credential.value, "")
    }
}
