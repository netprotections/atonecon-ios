//
//  AtoneConTests.swift
//  AtoneConTests
//
//  Created by Pham Ngoc Hanh on 6/28/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import XCTest
@testable import AtoneCon

final class AtoneConTests: XCTestCase {

    override class func setUp() {
        super.setUp()
        var payment: AtoneCon.Payment!
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

    func testConfigShouldReturnRightOptionWhenConfig() {
        // When
        let option = AtoneCon.Options(publicKey: "abcxyz")
        AtoneCon.shared.config(option)

        // Then 
        XCTAssertEqual(AtoneCon.shared.option?.publicKey, "abcxyz")
    }

    func testResetAuthenTokenShouldReturnEmptyAuthenTokenWhenResetAuthenToken() {
        // When 
        Session.shared.credential = Session.Credential(value: "aaabbbccc")
        AtoneCon.shared.resetAuthenToken()

        // Then 
        XCTAssertEqual(Session.shared.credential.value, "")
    }
}
