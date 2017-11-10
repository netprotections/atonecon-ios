//
//  PaymentViewModel.swift
//  AtoneConDemo
//
//  Created by Pham Ngoc Hanh on 7/4/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation
import AtoneCon

final class PaymentViewModel {
    private var payment: AtoneCon.Payment {
        // TODO: dummy data
        var payment = AtoneCon.Payment(
            amount: 10,
            shopTransactionNo: "",
            checksum: "ikIqa9qe/8Bxv6oOgmrYuIzphxr+0yW7HYbQu/WgUz4=")
        payment.salesSettled = false
        payment.descriptionTrans = "備考です。"
        payment.transactionOptions = []
        payment.userNo = "user_no-1509419147"
        payment.customer = customer
        payment.desCustomers = desCustomers
        payment.items = items
        return payment
    }

    // TODO: dummy data
    private var customer: AtoneCon.Customer {
        var customer = AtoneCon.Customer(name: "接続テスト")
        customer.familyName = "接続"
        customer.givenName = "テスト"
        customer.nameKana = "セツゾクテスト"
        customer.familyNameKana = "セツゾク"
        customer.givenNameKana = "テスト"
        customer.sexDivision = "1"
        customer.companyName = "（株）ネットプロテクションズ"
        customer.department = "セールスグループ"
        customer.zipCode = "8491611"
        customer.address = "東京都中央区銀座１－１０ー６　銀座ファーストビル４階"
        customer.tel = "080-1234-1234"
        customer.email = "m_register_test0001@fufururu.info"
        customer.birthday = "1984-08-17"
        customer.phoneNumber = "09062910606"
        customer.totalPurchaseAmount = 1_000
        customer.totalPurchaseCount = 2_000
        return customer
    }

    // TODO: dummy data
    private var desCustomers: [AtoneCon.DesCustomer] {
        var desCustomer = AtoneCon.DesCustomer(name: "銀座太郎", zipCode: "123-1234", address: "東京都中央区銀座１－１０ー６　銀座ファーストビル４階")
        desCustomer.nameKana = "ぎんざたろう"
        desCustomer.companyName = "株式会社ネットプロテクションズ"
        desCustomer.department = "システム部門"
        desCustomer.tel = "0312341234"
        return [desCustomer]
    }

    // TODO: dummy data
    private var items: [AtoneCon.Item] {
        var item = AtoneCon.Item(id: "1", name: "１０円チョコ", price: 10, count: 1)
        item.url = "https://atone.be/items/1"
        return [item]
    }

    func saveAuthenToken(token: String?) {
        userDefault.setValue(token, forKey: Define.String.tokenKey)
    }

    func getAuthenToken() -> String? {
        return userDefault.string(forKey: Define.String.tokenKey)
    }

    func resetAuthenToken() {
        AtoneCon.shared.resetAuthenToken()
        userDefault.removeObject(forKey: Define.String.tokenKey)
    }

    func payment(withTransaction transaction: String?) -> AtoneCon.Payment {
        var payment = self.payment
        if let transaction = transaction {
            payment.shopTransactionNo = transaction
        }
        return payment
    }
}
