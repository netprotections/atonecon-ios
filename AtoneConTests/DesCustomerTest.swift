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

final class DesCustomerTest: XCTestCase {

    private var desCustomer: AtoneCon.DesCustomer?
    private var desCustomerJson: [String:Any] = [:]

    override func setUp() {
        super.setUp()
        desCustomer = AtoneCon.DesCustomer(name: "duy", zipCode: "1234567890", address: "DaNang")
        desCustomer?.department = "AsianTech"
        desCustomer?.email = "duy.nguyen@asiantech.vn"

        desCustomerJson = ["dest_email": "duy.nguyen@asiantech.vn",
                           "dest_zip_code": "1234567890",
                           "dest_address": "DaNang",
                           "dest_department": "AsianTech",
                           "dest_customer_name": "duy"]
    }

    func testInit() {
        guard let desCustomer = desCustomer else {
            fatalError("desCustomer hasn't beeen initialized")
        }
        XCTAssertEqual(desCustomer.name, "duy")
        XCTAssertEqual(desCustomer.zipCode, "1234567890")
        XCTAssertEqual(desCustomer.address, "DaNang")
    }

    func testMapping() {
        guard let result = Mapper<AtoneCon.DesCustomer>().map(JSON: desCustomerJson) else {
            fatalError("Wrong JSON format.")
        }
        guard let desCustomer = desCustomer else {
            fatalError("desCustomer hasn't beeen initialized")
        }
        XCTAssertEqual(result.name, desCustomer.name)
        XCTAssertEqual(result.zipCode, desCustomer.zipCode)
        XCTAssertEqual(result.address, desCustomer.address)
        XCTAssertEqual(result.department, desCustomer.department)
        XCTAssertEqual(result.email, desCustomer.email)
    }
}
