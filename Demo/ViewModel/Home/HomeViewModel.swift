//
//  HomeViewModel.swift
//  Demo
//
//  Created by Pham Ngoc Hanh on 7/4/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation
import AtoneCon

let userDefault = UserDefaults.standard

final class HomeViewModel {
    var payment: AtoneCon.Payment {
        // TODO: dummy data
        var payment = AtoneCon.Payment(
            amount: 10,
            shopTransactionNo: "shop-tran-no-1500347802",
            checksum: "iq4gHR9I8LTszpozjDIaykNjuIsYg+m/pR6JFKggr5Q=")
        payment.salesSettled = false
        payment.descriptionTrans = "備考です。"

        payment.customer = customer
        payment.desCustomers = desCustomers
        payment.items = items
        return payment
    }

    // TODO: dummy data
    private var customer: AtoneCon.Customer {
        var customer = AtoneCon.Customer(name: "接続テスト")
        customer.nameKana = "セツゾクテスト"
        customer.companyName = "（株）ネットプロテクションズ"
        customer.department = "セールスグループ"
        customer.zipCode = "1234567"
        customer.address = "東京都中央区銀座１－１０ー６　銀座ファーストビル４階"
        customer.tel = "080-1234-1234"
        customer.email = "np@netprotections.co.jp"
        customer.totalPurchaseAmount = 20000
        customer.totalPurchaseCount = 2
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
        userDefault.set(token, forKey: Define.String.tokenKey)
    }

    func getAuthenToken() -> String? {
        return userDefault.string(forKey: Define.String.tokenKey)
    }

    func resetAuthenToken() {
        AtoneCon.shared.resetAuthenToken()
        userDefault.removeObject(forKey: Define.String.tokenKey)
    }
}
