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

class PaymentTest: XCTestCase {

    private var paymentTest: AtoneCon.Payment {
        let customer = AtoneCon.Customer(name: "hanh")
        let desCustomer = AtoneCon.DesCustomer(name: "duy", zipCode: "123123", address: "DaNang")
        let item = AtoneCon.Item(id: "1", name: "quan", price: 100, count: 1)
        var payment = AtoneCon.Payment(
            amount: 10,
            shopTransactionNo: "shop-tran-no-123456789",
            checksum: "iq4gHR9I8LTszpozjDIaykNjuIsYg+m/pR6JFKggr5Q=")
        payment.salesSettled = false
        payment.descriptionTrans = "haha"
        payment.customer = customer
        payment.desCustomers = [desCustomer]
        payment.items = [item]

        return payment
    }

    private let paymentJson: [String:Any] = [
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

    func testInitPayment() {
        print(paymentTest.toJSON())
        XCTAssertEqual(paymentTest.amount, 10)
        XCTAssertEqual(paymentTest.shopTransactionNo, "shop-tran-no-123456789")
        XCTAssertEqual(paymentTest.checksum, "iq4gHR9I8LTszpozjDIaykNjuIsYg+m/pR6JFKggr5Q=")
        XCTAssertEqual(paymentTest.salesSettled, false)
        XCTAssertEqual(paymentTest.descriptionTrans, "haha")
        XCTAssertEqual(paymentTest.customer.name, "hanh")
        XCTAssertEqual(paymentTest.items.count, 1)
        XCTAssertEqual(paymentTest.desCustomers?.count, 1)
    }

    func testMapping() {
        guard let payment = Mapper<AtoneCon.Payment>().map(JSON: paymentJson) else {
            fatalError("Wrong JSON format.")
        }
        XCTAssertEqual(payment.amount, paymentTest.amount)
        XCTAssertEqual(payment.shopTransactionNo, paymentTest.shopTransactionNo)
        XCTAssertEqual(payment.checksum, paymentTest.checksum)
        XCTAssertEqual(payment.descriptionTrans, paymentTest.descriptionTrans)
        XCTAssertEqual(payment.salesSettled, paymentTest.salesSettled)
        XCTAssertEqual(payment.customer.name, paymentTest.customer.name)
        XCTAssertEqual(payment.desCustomers?.count, paymentTest.desCustomers?.count)
        XCTAssertEqual(payment.items.count, paymentTest.items.count)
    }
}
