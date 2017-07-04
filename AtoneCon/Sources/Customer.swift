//
//  Customer.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 7/4/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation

extension AtoneCon {
    public struct Customer {
        private var name =  ""
        private var familyName = ""
        private var givenName = ""
        private var nameKana = ""
        private var familyNameKana = ""
        private var givenNameKana = ""
        private var phoneNumber = ""
        private var birthday = ""
        private var sexDivision = ""
        private var companyName = ""
        private var department = ""
        private var zipCode = ""
        private var address = ""
        private var tel = ""
        private var email = ""
        private var totalPurchaseCount = 0
        private var totalPurchaseAmount = 0

        public init(name: String, familyName: String, givenName: String, nameKana: String, familyNameKana: String, givenNameKana: String, phoneNumber: String, birthday: String, sexDivision: String, companyName: String, department: String, zipCode: String, address: String, tel: String, email: String, totalPurchaseCount: Int, totalPurchaseAmount: Int) {

            self.name = name
            self.familyName = familyName
            self.givenName = givenName
            self.nameKana = nameKana
            self.familyNameKana = familyNameKana
            self.givenNameKana = givenNameKana
            self.phoneNumber = phoneNumber
            self.birthday = birthday
            self.sexDivision = sexDivision
            self.companyName = companyName
            self.department = department
            self.zipCode = zipCode
            self.address = address
            self.tel = tel
            self.email = email
            self.totalPurchaseCount = totalPurchaseCount
            self.totalPurchaseAmount = totalPurchaseAmount
        }
    }
}
