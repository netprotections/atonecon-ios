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
        private var name = ""
        private var nameKana = ""
        private var companyName = ""
        private var department = ""
        private var zipCode = ""
        private var address = ""
        private var tel = ""
        private var email = ""

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
    }
}
