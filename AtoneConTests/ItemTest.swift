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

    func testInitObjetMapper() {
        // When
        let map = Map(mappingType: .fromJSON, JSON: [:], toObject: false, context: nil, shouldIncludeNilValues: true)
        guard let item: AtoneCon.Item = AtoneCon.Item(map: map) else { return }

        // Then
        XCTAssertEqual(item.id, "")
        XCTAssertEqual(item.name, "")
        XCTAssertEqual(item.price, 0)
        XCTAssertEqual(item.count, 0)
        XCTAssertEqual(item.price, 0)
        XCTAssertNil(item.url)
    }

    func testMapping() {
        // When 
        var item = AtoneCon.Item(id: "2", name: "ao", price: 100, count: 3)
        item.url = "google.com"

        // Then
        XCTAssertNotNil(item.toJSONString())
        if let jsonString = item.toJSONString() {
            print(jsonString)
            XCTAssertEqual(jsonString, "{\"item_name\":\"ao\",\"item_price\":100,\"item_url\":\"google.com\",\"shop_item_id\":\"2\",\"item_count\":3}")
        }
    }
}
