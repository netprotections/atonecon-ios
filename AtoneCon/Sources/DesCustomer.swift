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
