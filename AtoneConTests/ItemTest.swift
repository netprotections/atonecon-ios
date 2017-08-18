//
//  ItemTest.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 8/18/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import XCTest
@testable import AtoneCon

class ItemTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInitItem() {
        // Given
        var item = AtoneCon.Item(id: "1", name: "１０円チョコ", price: 10, count: 1)
        item.url = "https://atone.be/items/1"

        // Then
        XCTAssertEqual(item.id, "1")
        XCTAssertEqual(item.name, "１０円チョコ")
        XCTAssertEqual(item.price, 10)
        XCTAssertEqual(item.count, 1)
        XCTAssertEqual(item.url, "https://atone.be/items/1")
    }
}
