//
//  StringTest.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 8/18/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import XCTest
@testable import AtoneCon

final class StringTests: XCTestCase {

    func testLocalizedShouldReturnStringResultWhenItWasDefinedInLocalizableString() {
        // When "okay" was defined is "OK" in localizable.strings
        let test = "okay"

        // Then
        XCTAssertEqual(test.localized(), "OK")
    }

    func testLocalizedShouldReturnItselftWhenItWasNotDefinedInLocalizableString() {
        // When "hanh" was not defined in localizable.strings
        let test = "hanh"

        // Then
        XCTAssertEqual(test.localized(), "hanh")
    }
}
