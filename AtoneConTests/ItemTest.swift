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

    private var itemTest: AtoneCon.Item {
        var item = AtoneCon.Item(id: "2", name: "ao", price: 100, count: 3)
        item.url = "google.com"
        return item
    }

    private let itemJson: [String : Any] = ["item_name": "ao",
                                            "shop_item_id": "2",
                                            "item_price": 100,
                                            "item_count": 3,
                                            "item_url": "google.com"]

    func testInitItem() {
        XCTAssertEqual(itemTest.id, "2")
        XCTAssertEqual(itemTest.name, "ao")
        XCTAssertEqual(itemTest.price, 100)
        XCTAssertEqual(itemTest.count, 3)
    }

    func testMapping() {
        guard let item = Mapper<AtoneCon.Item>().map(JSON: itemJson) else {
            fatalError("Wrong JSON format.")
        }
        XCTAssertEqual(item.id, itemTest.id)
        XCTAssertEqual(item.name, itemTest.name)
        XCTAssertEqual(item.price, itemTest.price)
        XCTAssertEqual(item.count, itemTest.count)
        XCTAssertEqual(item.url, itemTest.url)
    }
}
