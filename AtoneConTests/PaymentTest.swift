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

final class PaymentTest: XCTestCase {

    private var payment: AtoneCon.Payment?
    private var paymentJson: [String:Any] = [:]

    override func setUp() {
        super.setUp()

        let customer = AtoneCon.Customer(name: "hanh")
        let desCustomer = AtoneCon.DesCustomer(name: "duy", zipCode: "123123", address: "DaNang")
        let item = AtoneCon.Item(id: "1", name: "quan", price: 100, count: 1)

        payment = AtoneCon.Payment(
            amount: 10,
            shopTransactionNo: "shop-tran-no-123456789",
            checksum: "iq4gHR9I8LTszpozjDIaykNjuIsYg+m/pR6JFKggr5Q=")
        payment?.salesSettled = false
        payment?.descriptionTrans = "haha"
        payment?.customer = customer
        payment?.desCustomers = [desCustomer]
        payment?.items = [item]

        paymentJson = [
            "amount": 10,
            "shop_transaction_no": "shop-tran-no-123456789",
            "checksum": "iq4gHR9I8LTszpozjDIaykNjuIsYg+m/pR6JFKggr5Q=",
            "sales_settled": false,
            "description_trans": "haha",
            "customer": [
                "customer_name": "hanh"
            ],
            "dest_customers": [
                [
                    "dest_zip_code": "123123",
                    "dest_address": "DaNang",
                    "dest_customer_name": "duy"
                ]
            ],
            "items": [
                [
                    "item_name": "quan",
                    "shop_item_id": "1",
                    "item_price": 100,
                    "item_count": 1
                ]
            ]
        ]
    }

    func testInit() {
        guard let payment = payment else {
            fatalError("payment hasn't been initialized")
        }
        XCTAssertEqual(payment.amount, 10)
        XCTAssertEqual(payment.shopTransactionNo, "shop-tran-no-123456789")
        XCTAssertEqual(payment.checksum, "iq4gHR9I8LTszpozjDIaykNjuIsYg+m/pR6JFKggr5Q=")
        XCTAssertEqual(payment.salesSettled, false)
        XCTAssertEqual(payment.descriptionTrans, "haha")
        XCTAssertEqual(payment.customer.name, "hanh")
        XCTAssertEqual(payment.items.count, 1)
        XCTAssertEqual(payment.desCustomers?.count, 1)
    }

    func testMapping() {
        guard let result = Mapper<AtoneCon.Payment>().map(JSON: paymentJson) else {
            fatalError("Wrong JSON format.")
        }
        guard let payment = payment else {
            fatalError("payment hasn't been initialized")
        }
        XCTAssertEqual(result.amount, payment.amount)
        XCTAssertEqual(result.shopTransactionNo, payment.shopTransactionNo)
        XCTAssertEqual(result.checksum, payment.checksum)
        XCTAssertEqual(result.descriptionTrans, payment.descriptionTrans)
        XCTAssertEqual(result.salesSettled, payment.salesSettled)
        XCTAssertEqual(result.customer.name, payment.customer.name)
        XCTAssertEqual(result.desCustomers?.count, payment.desCustomers?.count)
        XCTAssertEqual(result.items.count, payment.items.count)
    }
}
