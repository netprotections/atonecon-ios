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

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInitPayment() {
        // When
        var customer = AtoneCon.Customer(name: "接続テスト")
        customer.nameKana = "セツゾクテスト"
        customer.companyName = "（株）ネットプロテクションズ"
        customer.department = "セールスグループ"
        customer.zipCode = "1234567"
        customer.address = "東京都中央区銀座１－１０ー６　銀座ファーストビル４階"
        customer.tel = "080-1234-1234"
        customer.email = "np@netprotections.co.jp"
        customer.totalPurchaseAmount = 20_000
        customer.totalPurchaseCount = 2

        var desCustomer = AtoneCon.DesCustomer(name: "銀座太郎", zipCode: "123-1234", address: "東京都中央区銀座１－１０ー６　銀座ファーストビル４階")
        desCustomer.nameKana = "ぎんざたろう"
        desCustomer.companyName = "株式会社ネットプロテクションズ"
        desCustomer.department = "システム部門"
        desCustomer.tel = "0312341234"

        var item = AtoneCon.Item(id: "1", name: "１０円チョコ", price: 10, count: 1)
        item.url = "https://atone.be/items/1"

        // Given
        var payment = AtoneCon.Payment(
            amount: 10,
            shopTransactionNo: "shop-tran-no-123456789",
            checksum: "iq4gHR9I8LTszpozjDIaykNjuIsYg+m/pR6JFKggr5Q=")
        payment.salesSettled = false
        payment.descriptionTrans = "備考です。"
        payment.customer = customer
        payment.desCustomers = [desCustomer]
        payment.items = [item]

        // Then
        XCTAssertEqual(payment.amount, 10)
        XCTAssertEqual(payment.shopTransactionNo, "shop-tran-no-123456789")
        XCTAssertEqual(payment.checksum, "iq4gHR9I8LTszpozjDIaykNjuIsYg+m/pR6JFKggr5Q=")
        XCTAssertEqual(payment.salesSettled, false)
        XCTAssertEqual(payment.descriptionTrans, "備考です。")
        XCTAssertEqual(payment.items.count, 1)
        XCTAssertEqual(payment.desCustomers?.count, 1)
    }

    func testInitObjetMapper() {
        // When
        let map = Map(mappingType: .toJSON, JSON: [:])
        guard let payment = AtoneCon.Payment(map: map) else { return }

        // Then
        XCTAssertEqual(payment.amount, 0)
        XCTAssertEqual(payment.shopTransactionNo, "")
        XCTAssertNil(payment.salesSettled)
        XCTAssertNil(payment.descriptionTrans)
        XCTAssertEqual(payment.checksum, "")
        XCTAssertEqual(payment.customer.name, "")
        XCTAssertNil(payment.desCustomers)
        XCTAssertEqual(payment.items.count, 0)
    }

    func testMapping() {
        // When
        let customer = AtoneCon.Customer(name: "hanh")
        let desCustomers: [AtoneCon.DesCustomer] = [AtoneCon.DesCustomer(name: "duy", zipCode: "0901238", address: "DaNang")]
        let items: [AtoneCon.Item] = [AtoneCon.Item(id: "1", name: "ao", price: 1_000, count: 2),
                     AtoneCon.Item(id: "2", name: "quan", price: 2_000, count: 3)]
        var payment = AtoneCon.Payment(amount: 8_000, shopTransactionNo: "shop-tran-no-01", checksum: "abcxyz")
        payment.customer = customer
        payment.desCustomers = desCustomers
        payment.items = items

        let json: String? = "{\"customer\":{\"customer_name\":\"hanh\"}," +
        "\"items\":[" +
            "{\"item_name\":\"ao\",\"item_price\":1000,\"shop_item_id\":\"1\",\"item_count\":2}," +
            "{\"item_name\":\"quan\",\"item_price\":2000,\"shop_item_id\":\"2\",\"item_count\":3}" +
        "]," +
        "\"checksum\":\"abcxyz\"," +
        "\"dest_customers\":[" +
            "{\"dest_address\":\"DaNang\",\"dest_zip_code\":\"0901238\",\"dest_customer_name\":\"duy\"}]," +
        "\"shop_transaction_no\":\"shop-tran-no-01\"," +
        "\"amount\":8000}"

        // Then
        XCTAssertNotNil(payment.toJSONString())
        XCTAssertEqual(payment.toJSONString(), json)
    }
}
