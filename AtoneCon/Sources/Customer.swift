//
//  Customer.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 7/4/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation
import ObjectMapper

extension AtoneCon {
    public struct Customer {
        public var name: String!
        public var familyName: String?
        public var givenName: String?
        public var nameKana: String?
        public var familyNameKana: String?
        public var givenNameKana: String?
        public var phoneNumber: String?
        public var birthday: String?
        public var sexDivision: String?
        public var companyName: String?
        public var department: String?
        public var zipCode: String?
        public var address: String?
        public var tel: String?
        public var email: String?
        public var totalPurchaseCount: Int?
        public var totalPurchaseAmount: Int?

        public init(name: String,
                    familyName: String?,
                    givenName: String?,
                    nameKana: String?,
                    familyNameKana: String?,
                    givenNameKana: String?,
                    phoneNumber: String?,
                    birthday: String?,
                    sexDivision: String?,
                    companyName: String?,
                    department: String?,
                    zipCode: String?,
                    address: String?,
                    tel: String?,
                    email: String?,
                    totalPurchaseCount: Int?,
                    totalPurchaseAmount: Int?) {
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

extension AtoneCon.Customer: Mappable {
    public init?(map: Map) {
    }

    public mutating func mapping(map: Map) {
        name <- map["customer_name"]
        familyName <- map["customer_family_name"]
        givenName <- map["customer_given_name"]
        nameKana <- map["customer_name_kana"]
        familyNameKana <- map["customer_family_name_kana"]
        givenNameKana <- map["customer_given_name_kana"]
        phoneNumber <- map["phone_number"]
        birthday <- map["birthday"]
        sexDivision <- map["sex_division"]
        companyName <- map["company_name"]
        department <- map["department"]
        zipCode <- map["zip_code"]
        address <- map["address"]
        tel <- map["tel"]
        email <- map["email"]
        totalPurchaseCount <- map["total_purchase_count"]
        totalPurchaseAmount <- map["total_purchase_amount"]
    }
}
