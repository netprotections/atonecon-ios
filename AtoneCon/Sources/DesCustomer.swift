//
//  DesCustomer.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 7/4/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation

extension AtoneCon {
    public struct DesCustomer {
        public var name = ""
        public var nameKana = ""
        public var companyName = ""
        public var department = ""
        public var zipCode = ""
        public var address = ""
        public var tel = ""
        public var email = ""

        public init(name: String,
                    nameKana: String,
                    companyName: String,
                    department: String,
                    zipCode: String,
                    address: String,
                    tel: String,
                    email: String) {
            self.name = name
            self.nameKana = nameKana
            self.companyName = companyName
            self.department = department
            self.zipCode = zipCode
            self.address = address
            self.tel = tel
            self.email = email
        }

        func toScriptString() -> String {
            let desCustomerScriptString =
                "{" +
                    "\"dest_customer_name\": \"" + name + "\", " +
                    "\"dest_customer_name_kana\": \"" + nameKana + "\", " +
                    "\"dest_company_name\": \"" + companyName + "\", " +
                    "\"dest_department\": \"" + department + "\", " +
                    "\"dest_zip_code\": \"" + zipCode + "\", " +
                    "\"dest_address\": \"" + address + "\", " +
                    "\"dest_tel\": \"" + tel + "\", " +
                    "\"dest_email\": \"" + email + "\"" +
                "}"
            return desCustomerScriptString
        }
    }
}
