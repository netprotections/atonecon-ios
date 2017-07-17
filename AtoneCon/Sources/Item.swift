//
//  Item.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 7/4/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation
import ObjectMapper

extension AtoneCon {
    public struct Item {
        public var id = ""
        public var name = ""
        public var price = 0
        public var count = 0
        public var url: String?

        public init(id: String,
                    name: String,
                    price: Int,
                    count: Int) {
            self.id = id
            self.name = name
            self.price = price
            self.count = count
        }
    }
}
extension AtoneCon.Item: Mappable {
    public init?(map: Map) {
    }

    public mutating func mapping(map: Map) {
        id <- map["shop_item_id"]
        name <- map["item_name"]
        price <- map["item_price"]
        count <- map["item_count"]
        url <- map["item_url"]
    }
}
