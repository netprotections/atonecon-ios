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

class CustomerTest: XCTestCase {

    private var customerTest: AtoneCon.Customer {
        var customer = AtoneCon.Customer(name: "hanh")
        customer.department = "AsianTech"
        customer.email = "hanh.pham@asiantech.vn"
        customer.phoneNumber = "01202423340"
        return customer
    }

    private let customerJson: [String:Any] = ["department": "AsianTech",
                                      "phone_number": "01202423340",
                                      "email": "hanh.pham@asiantech.vn",
                                      "customer_name": "hanh"]

    func testInitCustomer() {
        XCTAssertEqual(customerTest.name, "hanh")
    }

    func testMapping() {
        guard let customer = Mapper<AtoneCon.Customer>().map(JSON: customerJson) else {
            fatalError("Wrong JSON format.")
        }
        XCTAssertEqual(customer.name, customerTest.name)
        XCTAssertEqual(customer.department, customerTest.department)
        XCTAssertEqual(customer.email, customerTest.email)
        XCTAssertEqual(customer.phoneNumber, customerTest.phoneNumber)
    }
}
