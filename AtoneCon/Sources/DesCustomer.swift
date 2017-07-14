//
//  DesCustomer.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 7/4/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation
import ObjectMapper

extension AtoneCon {
    public struct DesCustomer {
        public var name = ""
        public var nameKana: String?
        public var companyName: String?
        public var department: String?
        public var zipCode = ""
        public var address = ""
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
    }
}

extension AtoneCon.DesCustomer: Mappable {
    public init?(map: Map) {

    }

    public mutating func mapping(map: Map) {
        name <- map["dest_customer_name"]
        nameKana <- map["dest_customer_name_kana"]
        companyName <- map["dest_company_name"]
        department <- map["dest_department"]
        zipCode <- map["dest_zip_code"]
        address <- map["dest_address"]
        tel <- map["dest_tel"]
        email <- map["dest_email"]
    }
}
