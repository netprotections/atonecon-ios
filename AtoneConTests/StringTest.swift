//
//  StringTest.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 8/18/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import XCTest
@testable import AtoneCon

final class StringTest: XCTestCase {
    func testLocalized() {
        // When
        let test = "okay"

        // Then
        XCTAssertEqual(test.localized(), "OK")
    }
}
