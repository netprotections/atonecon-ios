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
        public var name: String
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

        func toScriptString() -> String {
            let customerScriptString = "{" +
                "\"customer_name\": " + "\"" + name + "\", " +
                "\"customer_family_name\": " + "\"" + familyName.asStringOrNullText() + "\", " +
                "\"customer_given_name\": " + "\"" + givenName.asStringOrNullText() + "\", " +
                "\"customer_name_kana\": " + "\"" + nameKana.asStringOrNullText() + "\", " +
                "\"customer_family_name_kana\": " + "\"" + familyNameKana.asStringOrNullText() + "\", " +
                "\"customer_given_name_kana\": " + "\"" + givenNameKana.asStringOrNullText() + "\", " +
                "\"phone_number\": " + "\"" + phoneNumber.asStringOrNullText() + "\", " +
                "\"birthday\": " + "\"" + birthday.asStringOrNullText() + "\", " +
                "\"sex_division\": " + "\"" + sexDivision.asStringOrNullText() + "\", " +
                "\"company_name\": " + "\"" + companyName.asStringOrNullText() + "\", " +
                "\"department\": " + "\"" + department.asStringOrNullText() + "\", " +
                "\"zip_code\": " + "\"" + zipCode.asStringOrNullText() + "\", " +
                "\"address\": " + "\"" + address.asStringOrNullText() + "\", " +
                "\"tel\": " + "\"" + tel.asStringOrNullText() + "\", " +
                "\"email\": " + "\"" + email.asStringOrNullText() + "\", " +
                "\"total_purchase_count\": " + totalPurchaseCount.asStringOrNullText() + ", " +
                "\"total_purchase_amount\": " + totalPurchaseAmount.asStringOrNullText() +
            "}"
            return customerScriptString
        }
    }
}
