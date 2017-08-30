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
    private var itemJson: [String : Any] = [:]

    override func setUp() {
        super.setUp()
        item = AtoneCon.Item(id: "2", name: "ao", price: 100, count: 3)
        item.url = "google.com"

        itemJson = ["item_name": "ao",
         "shop_item_id": "2",
         "item_price": 100,
         "item_count": 3,
         "item_url": "google.com"]
    }

    func testInitShouldReturnItemObjectWhenInitialized() {
        XCTAssertNotNil(item)
        XCTAssertEqual(item.id, "2")
        XCTAssertEqual(item.name, "ao")
        XCTAssertEqual(item.price, 100)
        XCTAssertEqual(item.count, 3)
    }

    func testMappingShouldReturnItemObjectWhenMapDataFromJson() {
        let itemResult: AtoneCon.Item! = Mapper<AtoneCon.Item>().map(JSON: itemJson)
        XCTAssertNotNil(itemResult)
        XCTAssertNotNil(item)
        XCTAssertEqual(itemResult.id, item.id)
        XCTAssertEqual(itemResult.name, item.name)
        XCTAssertEqual(itemResult.price, item.price)
        XCTAssertEqual(itemResult.count, item.count)
        XCTAssertEqual(itemResult.url, item.url)
    }
}
