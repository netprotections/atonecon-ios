//
//  OptionsTest.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 8/18/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import XCTest
@testable import AtoneCon

class OptionsTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInitOptions() {
        // Given
        var options = AtoneCon.Options()
        options.publicKey = "publicKey"
        options.environment = .development

        // Then
        XCTAssertEqual(options.publicKey, "publicKey")
        XCTAssertEqual(options.environment, .development)
    }
}
