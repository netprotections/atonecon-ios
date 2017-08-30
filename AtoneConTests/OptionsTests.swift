//
//  OptionsTest.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 8/18/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import XCTest
@testable import AtoneCon

final class OptionsTests: XCTestCase {

    func testInitShouldReturnOptionsObjectWhenInitialized() {
        // Given
        let options = AtoneCon.Options(publicKey: "publicKey")

        // Then
        XCTAssertNotNil(options)
        XCTAssertEqual(options.publicKey, "publicKey")
    }
}
