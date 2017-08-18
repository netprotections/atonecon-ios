//
//  SessionTest.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 8/18/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import XCTest
@testable import AtoneCon

class SessionTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInitCredential() {
        // When
        let credential = Session.Credential(value: "tk_23adh123bvnjKhds")

        // Then
        XCTAssertEqual(credential.value, "tk_23adh123bvnjKhds")
    }

    func testloadCredential() {
        // When
        Session.shared.credential = Session.Credential(value: "tk_23adh123bvnjKhds")
        Session.shared.loadCredential()

        // Then
        XCTAssertEqual(Session.shared.credential.value, "tk_23adh123bvnjKhds")
    }

    func testClearCredential() {
        // When
        Session.shared.credential = Session.Credential(value: "tk_23adh123bvnjKhds")
        Session.shared.clearCredential()

        // Then
        XCTAssertEqual(Session.shared.credential.value, "")
    }
}
