//
//  Payment.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 6/30/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation
import ObjectMapper

extension AtoneCon {

    public struct Payment {
        public var amount = 0
        public var userNo: String?
        public var shopTransactionNo = ""
        public var salesSettled: Bool?
        public var descriptionTrans: String?
        public var checksum = ""
        public var transactionOptions: [Int] = []
        public var customer: Customer = Customer(name: "")
        public var serviceSupplier: Supplier?
        public var desCustomers: [DesCustomer]?
        public var items: [Item] = []

        public init(amount: Int,
                    shopTransactionNo: String,
                    checksum: String) {
            self.amount = amount
            self.shopTransactionNo = shopTransactionNo
            self.checksum = checksum
        }
    }
}

extension AtoneCon.Payment: Mappable {
    public init?(map: Map) {
    }

    public mutating func mapping(map: Map) {
        amount <- map["amount"]
        userNo <- map["user_no"]
        shopTransactionNo <- map["shop_transaction_no"]
        salesSettled <- map["sales_settled"]
        descriptionTrans <- map["description_trans"]
        transactionOptions <- map["transaction_options"]
        checksum <- map["checksum"]
        customer <- map["customer"]
        desCustomers <- map["dest_customers"]
        items <- map["items"]
        serviceSupplier <- map["service_supplier"]
    }
}
