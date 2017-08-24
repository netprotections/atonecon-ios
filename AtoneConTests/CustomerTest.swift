//
//  CustomerTest.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 8/18/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import AtoneCon

final class CustomerTest: XCTestCase {

    private var customer: AtoneCon.Customer?
    private var customerJson: [String:Any] = [:]

    override func setUp() {
        super.setUp()
        customer = AtoneCon.Customer(name: "hanh")
        customer?.department = "AsianTech"
        customer?.email = "hanh.pham@asiantech.vn"
        customer?.phoneNumber = "01202423340"

        customerJson = ["department": "AsianTech",
                        "phone_number": "01202423340",
                        "email": "hanh.pham@asiantech.vn",
                        "customer_name": "hanh"]
    }

    func testInit() {
        XCTAssertEqual(customer?.name, "hanh")
    }

    func testMapping() {
        guard let result = Mapper<AtoneCon.Customer>().map(JSON: customerJson) else {
            fatalError("Wrong JSON format.")
        }
        XCTAssertEqual(result.name, customer?.name)
        XCTAssertEqual(result.department, customer?.department)
        XCTAssertEqual(result.email, customer?.email)
        XCTAssertEqual(result.phoneNumber, customer?.phoneNumber)
    }
}
