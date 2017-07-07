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

        public var customer: Customer!
        public var desCustomers: [DesCustomer]?
        public var items: [Item] = []

        public var amount: Int
        public var shopTransactionNo: String
        public var salesSettled: Bool?
        public var descriptionTrans: String?
        public var checksum: String

        public init(amount: Int,
                    shopTransactionNo: String,
                    salesSettled: Bool?,
                    descriptionTrans: String?,
                    checksum: String) {
            self.amount = amount
            self.shopTransactionNo = shopTransactionNo
            self.salesSettled = salesSettled
            self.descriptionTrans = descriptionTrans
            self.checksum = checksum
        }

        internal func toScriptString() -> String {
            let customerScriptString = customer.toScriptString()

            var desCustomersScriptString = ""
            if let desCustomers = desCustomers {
                desCustomersScriptString = "["
                for index in 0..<desCustomers.count {
                    if index == desCustomers.count - 1 {
                        desCustomersScriptString += desCustomers[index].toScriptString() + "]"
                    } else {
                        desCustomersScriptString += desCustomers[index].toScriptString() + ", "
                    }
                }
            } else {
                desCustomersScriptString = "null"
            }

            var itemsScriptString = "["
            for index in 0..<items.count {
                if index == items.count - 1 {
                    itemsScriptString += items[index].toScriptString() + "]"
                } else {
                    itemsScriptString += items[index].toScriptString() + ", "
                }
            }

            let paymentScriptString = "var data = {" +
                "\"amount\": " + "\(amount)" + ", " +
                "\"shop_transaction_no\": " + "\"" + shopTransactionNo + "\", " +
                "\"sales_settled\": " + salesSettled.asStringOrNullText() + ", " +
                "\"description_trans\": " + "\"" + descriptionTrans.asStringOrNullText() + "\", " +
                "\"checksum\": " + "\"" + checksum + "\", " +
                "\"customer\": " + customerScriptString + ", " +
                "\"dest_customers\": " + desCustomersScriptString + ", " +
                "\"items\": " + itemsScriptString +
            "}"
            return paymentScriptString
        }
    }
}
