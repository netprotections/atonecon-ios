//
//  DesCustomerTest.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 8/18/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import XCTest
@testable import AtoneCon

class DesCustomerTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInitDesCustomer() {
        // Given
        var desCustomer = AtoneCon.DesCustomer(name: "銀座太郎", zipCode: "123-1234", address: "東京都中央区銀座１－１０ー６　銀座ファーストビル４階")
        desCustomer.nameKana = "ぎんざたろう"
        desCustomer.companyName = "株式会社ネットプロテクションズ"
        desCustomer.department = "システム部門"
        desCustomer.tel = "0312341234"

        // Then
        XCTAssertEqual(desCustomer.name, "銀座太郎")
        XCTAssertEqual(desCustomer.zipCode, "123-1234")
        XCTAssertEqual(desCustomer.address, "東京都中央区銀座１－１０ー６　銀座ファーストビル４階")
        XCTAssertEqual(desCustomer.nameKana, "ぎんざたろう")
        XCTAssertEqual(desCustomer.companyName, "株式会社ネットプロテクションズ")
        XCTAssertEqual(desCustomer.department, "システム部門")
        XCTAssertEqual(desCustomer.tel, "0312341234")
        XCTAssertEqual(desCustomer.email, nil)
    }
}
