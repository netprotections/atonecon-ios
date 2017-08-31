//
//  PaymentTest.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 8/18/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import AtoneCon

final class PaymentTests: XCTestCase {

    private var payment: AtoneCon.Payment!

    override func setUp() {
        super.setUp()

        let customer = AtoneCon.Customer(name: "hanh")
        let desCustomer = AtoneCon.DesCustomer(name: "duy", zipCode: "123123", address: "DaNang")
        let item = AtoneCon.Item(id: "1", name: "quan", price: 100, count: 1)

        payment = AtoneCon.Payment(
            amount: 10,
            shopTransactionNo: "shop-tran-no-123456789",
            checksum: "iq4gHR9I8LTszpozjDIaykNjuIsYg+m/pR6JFKggr5Q=")
        payment.salesSettled = false
        payment.descriptionTrans = "haha"
        payment.customer = customer
        payment.desCustomers = [desCustomer]
        payment.items = [item]
    }

    func testInitShouldReturnValidWhenInitialized() {
        XCTAssertNotNil(payment)
        XCTAssertEqual(payment.amount, 10)
        XCTAssertEqual(payment.shopTransactionNo, "shop-tran-no-123456789")
        XCTAssertEqual(payment.checksum, "iq4gHR9I8LTszpozjDIaykNjuIsYg+m/pR6JFKggr5Q=")
        XCTAssertEqual(payment.salesSettled, false)
        XCTAssertEqual(payment.descriptionTrans, "haha")
        XCTAssertEqual(payment.customer.name, "hanh")
        XCTAssertEqual(payment.items.count, 1)
        XCTAssertNotNil(payment.desCustomers)
        XCTAssertEqual(payment.desCustomers?.count, 1)
    }
}
