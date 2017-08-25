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

final class CustomerTests: XCTestCase {

    private var customer: AtoneCon.Customer!
    private var customerJson: [String:Any] = [:]

    override func setUp() {
        super.setUp()
        customer = AtoneCon.Customer(name: "hanh")
        customer.department = "AsianTech"
        customer.email = "hanh.pham@asiantech.vn"
        customer.phoneNumber = "01202423340"

        customerJson = ["department": "AsianTech",
                        "phone_number": "01202423340",
                        "email": "hanh.pham@asiantech.vn",
                        "customer_name": "hanh"]
    }

    func testInitShouldReturnCustomerObjectWhenInitialized() {
        XCTAssertNotNil(customer)
        XCTAssertEqual(customer.name, "hanh")
    }

    func testMappingShouldReturnCustomerObjectWhenMapDataFromJson() {
        let customerResult: AtoneCon.Customer! = Mapper<AtoneCon.Customer>().map(JSON: customerJson)
        XCTAssertNotNil(customerResult)
        XCTAssertNotNil(customer)
        XCTAssertEqual(customerResult.name, customer.name)
        XCTAssertEqual(customerResult.department, customer.department)
        XCTAssertEqual(customerResult.email, customer.email)
        XCTAssertEqual(customerResult.phoneNumber, customer.phoneNumber)
    }
}
