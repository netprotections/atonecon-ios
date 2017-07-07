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
        public var name: String
        public var nameKana: String?
        public var companyName: String?
        public var department: String?
        public var zipCode: String
        public var address: String
        public var tel: String?
        public var email: String?

        public init(name: String,
                    nameKana: String?,
                    companyName: String?,
                    department: String?,
                    zipCode: String,
                    address: String,
                    tel: String?,
                    email: String?) {
            self.name = name
            self.nameKana = nameKana
            self.companyName = companyName
            self.department = department
            self.zipCode = zipCode
            self.address = address
            self.tel = tel
            self.email = email
        }

        internal func toScriptString() -> String {
            let desCustomerScriptString = "{" +
                "\"dest_customer_name\": " + "\"" + name + "\", " +
                "\"dest_customer_name_kana\": " + "\"" + nameKana.asStringOrNullText() + "\", " +
                "\"dest_company_name\": " + "\"" + companyName.asStringOrNullText() + "\", " +
                "\"dest_department\": " + "\"" + department.asStringOrNullText() + "\", " +
                "\"dest_zip_code\": " + "\"" + zipCode + "\", " +
                "\"dest_address\": " + "\"" + address + "\", " +
                "\"dest_tel\": " + "\"" + tel.asStringOrNullText() + "\", " +
                "\"dest_email\": " + email.asStringOrNullText() +
            "}"
            return desCustomerScriptString
        }
    }
}
