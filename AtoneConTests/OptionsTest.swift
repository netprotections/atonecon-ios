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
    func testInitOptions() {
        // Given
        let options = AtoneCon.Options(publicKey: "publicKey")

        // Then
        XCTAssertEqual(options.publicKey, "publicKey")
    }
}
