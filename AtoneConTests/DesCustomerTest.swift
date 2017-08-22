//
//  DesCustomerTest.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 8/18/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import AtoneCon

class DesCustomerTest: XCTestCase {

    private var desCustomerTest: AtoneCon.DesCustomer {
        var desCustomer = AtoneCon.DesCustomer(name: "duy", zipCode: "1234567890", address: "DaNang")
        desCustomer.department = "AsianTech"
        desCustomer.email = "duy.nguyen@asiantech.vn"
        return desCustomer
    }

    func testInitDesCustomer() {
        XCTAssertEqual(desCustomerTest.name, "duy")
        XCTAssertEqual(desCustomerTest.zipCode, "1234567890")
        XCTAssertEqual(desCustomerTest.address, "DaNang")
    }

    func testMapping() {
        // When
        let desCustomerJson: [String:Any] = ["dest_email": "duy.nguyen@asiantech.vn",
                                             "dest_zip_code": "1234567890",
                                             "dest_address": "DaNang",
                                             "dest_department": "AsianTech",
                                             "dest_customer_name": "duy"]

        // Then
        guard let desCustomer = Mapper<AtoneCon.DesCustomer>().map(JSON: desCustomerJson) else {
            fatalError("Wrong JSON format.")
        }
        XCTAssertEqual(desCustomer.name, desCustomerTest.name)
        XCTAssertEqual(desCustomer.zipCode, desCustomerTest.zipCode)
        XCTAssertEqual(desCustomer.address, desCustomerTest.address)
        XCTAssertEqual(desCustomer.department, desCustomerTest.department)
        XCTAssertEqual(desCustomer.email, desCustomerTest.email)
    }
}
