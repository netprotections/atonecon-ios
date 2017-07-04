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
        private var id = ""
        private var name = ""
        private var price = 0
        private var count = 0
        private var url = ""

        public init(id: String, name: String, price: Int, count: Int, url: String) {
            self.id = id
            self.name = name
            self.price = price
            self.count = count
            self.url = url
        }
    }
}
