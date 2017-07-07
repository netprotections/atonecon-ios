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

        public var amount = 0
        public var shopTransactionNo = ""
        public var salesSettled: Bool?
        public var descriptionTrans: String?
        public var checksum = ""

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
    }
}
