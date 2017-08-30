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

final class DesCustomerTests: XCTestCase {

    private var desCustomer: AtoneCon.DesCustomer!

    override func setUp() {
        super.setUp()
        desCustomer = AtoneCon.DesCustomer(name: "duy", zipCode: "1234567890", address: "DaNang")
        desCustomer.department = "AsianTech"
        desCustomer.email = "duy.nguyen@asiantech.vn"
    }

    func testInitShouldReturnReturnValidWhenInitialized() {
        XCTAssertNotNil(desCustomer)
        XCTAssertEqual(desCustomer.name, "duy")
        XCTAssertEqual(desCustomer.zipCode, "1234567890")
        XCTAssertEqual(desCustomer.address, "DaNang")
    }
}
