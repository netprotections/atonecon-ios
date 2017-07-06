//
//  Payment.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 6/30/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation

extension AtoneCon {

    public struct Payment {

        public var customer: Customer?
        public var desCustomers: [DesCustomer] = []
        public var items: [Item] = []

        public var amount = 0
        public var shopTransactionNo = ""
        public var salesSettled = false
        public var descriptionTrans = ""
        public var checksum = ""

        public init(amount: Int,
                    shopTransactionNo: String,
                    salesSettled: Bool,
                    descriptionTrans: String,
                    checksum: String) {
            self.amount = amount
            self.shopTransactionNo = shopTransactionNo
            self.salesSettled = salesSettled
            self.descriptionTrans = descriptionTrans
            self.checksum = checksum
        }

        func toScriptString() -> String {
            var desCustomerScriptString = "["
            for index in 0..<desCustomers.count {
                if index != desCustomers.count - 1 {
                    desCustomerScriptString += desCustomers[index].toScriptString() + ","
                } else {
                    desCustomerScriptString += desCustomers[index].toScriptString() + "]"
                }
            }

            var itemsScriptString = "["
            for index in 0..<items.count {
                if index != items.count - 1 {
                    itemsScriptString += items[index].toScriptString() + ","
                } else {
                    itemsScriptString += items[index].toScriptString() + "]"
                }
            }

            var customerScriptString = ""
            if let script = customer?.toScriptString() {
                customerScriptString = script
            }

            let paymentScripString =
                "var data = {" +
                "\"amount\": " + "\(amount)" + ", " +
                "\"shop_transaction_no\": " + "\"" + "\(shopTransactionNo)" + "\", " +
                "\"sales_settled\": " + "\(salesSettled)" + ", " +
                "\"description_trans\": " + "\"" + "\(descriptionTrans)" + "\", " +
                "\"checksum\": " + "\"" + "\(checksum)" + "\", " +
                "\"customer\": " + customerScriptString + ", " +
                "\"dest_customers\": " + customerScriptString + ", " +
                "\"items\": " + itemsScriptString + "}"
            return paymentScripString
        }
    }
}
