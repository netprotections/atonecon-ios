//
//  Item.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 7/4/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation

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
                    count: Int,
                    url: String?) {
            self.id = id
            self.name = name
            self.price = price
            self.count = count
            self.url = url
        }

        func toScriptString() -> String {
            let itemScriptString =
                "{" +
                    "\"shop_item_id\": \"" + id + "\", " +
                    "\"item_name\": \"" + name + "\", " +
                    "\"item_price\": \"" + "\(price)" + "\", " +
                    "\"item_count\": \"" + "\(count)" + "\", " +
                    "\"item_url\": \"" + url + "\"" +
                "}"
            return itemScriptString
        }
    }
}
