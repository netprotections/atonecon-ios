//
//  ItemTest.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 8/18/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import AtoneCon

final class ItemTests: XCTestCase {

    private var item: AtoneCon.Item!

    override func setUp() {
        super.setUp()
        item = AtoneCon.Item(id: "2", name: "ao", price: 100, count: 3)
        item.url = "google.com"
    }

    func testInitShouldReturnValidWhenInitialized() {
        XCTAssertNotNil(item)
        XCTAssertEqual(item.id, "2")
        XCTAssertEqual(item.name, "ao")
        XCTAssertEqual(item.price, 100)
        XCTAssertEqual(item.count, 3)
    }
}
