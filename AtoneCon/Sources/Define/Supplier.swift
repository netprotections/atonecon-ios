//
//  Supplier.swift
//  AtoneCon
//
//  Created by MBA0243P on 5/26/20.
//  Copyright © 2020 AsianTech Inc. All rights reserved.
//

import Foundation
import ObjectMapper

extension AtoneCon {
    public struct Supplier {
        public var shopCustomerId: String?
        public var membershipPeriod: Int?
        public var identificationStatus: [Int]?
        public var totalSalesCount: Int?
        public var totalSalesAmount: Int?
        public var pastMerchandiseCategory: [[String]?]?
        
        public init(shopCustomerId: String?) {
            self.shopCustomerId = shopCustomerId
        }
    }
}

extension AtoneCon.Supplier: Mappable {
    public init?(map: Map) {
    }
    
    public mutating func mapping(map: Map) {
        shopCustomerId <- map["shop_customer_id"]
        membershipPeriod <- map["membership_period"]
        identificationStatus <- map["identification_status"]
        totalSalesCount <- map["total_sales_count"]
        totalSalesAmount <- map["total_sales_amount"]
        pastMerchandiseCategory <- map["past_merchandise_category"]
    }
}
