//
//  HelperTest.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 8/18/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import XCTest
@testable import AtoneCon

final class HelperTest: XCTestCase {
    func testSizeDevice() {
        // When
        let iphone4 = Define.Helper.DeviceType.iPhone4
        let iphone5 = Define.Helper.DeviceType.iPhone5
        let iphone6 = Define.Helper.DeviceType.iPhone6
        let iphone6p = Define.Helper.DeviceType.iPhone6p
        let iPad = Define.Helper.DeviceType.iPad

        // Then
        XCTAssertEqual(iphone4.size, CGSize(width: 320, height: 480))
        XCTAssertEqual(iphone5.size, CGSize(width: 320, height: 568))
        XCTAssertEqual(iphone6.size, CGSize(width: 375, height: 667))
        XCTAssertEqual(iphone6p.size, CGSize(width: 414, height: 736))
        XCTAssertEqual(iPad.size, CGSize(width: 768, height: 1_024))
    }
}
