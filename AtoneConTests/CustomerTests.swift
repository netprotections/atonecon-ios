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

    override func setUp() {
        super.setUp()
        customer = AtoneCon.Customer(name: "hanh")
        customer.department = "AsianTech"
        customer.email = "hanh.pham@asiantech.vn"
        customer.phoneNumber = "01202423340"
    }

    func testInitShouldReturnValidWhenInitialized() {
        XCTAssertNotNil(customer)
        XCTAssertEqual(customer.name, "hanh")
    }
}
