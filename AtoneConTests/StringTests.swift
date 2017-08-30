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
        let okay = "okay"
        let network = "network"
        let cancel = "cancel"
        let close = "close"
        let quitPayment = "quitPayment"
        let networkError = "networkError"

        // Then
        XCTAssertEqual(okay.localized(), "OK")
        XCTAssertEqual(network.localized(), "ネットワーク")
        XCTAssertEqual(cancel.localized(), "キャンセル")
        XCTAssertEqual(close.localized(), "閉じる")
        XCTAssertEqual(quitPayment.localized(), "決済が終了します。よろしいでしょうか？")
        XCTAssertEqual(networkError.localized(), "ネットワークが圏外です")
    }
}
