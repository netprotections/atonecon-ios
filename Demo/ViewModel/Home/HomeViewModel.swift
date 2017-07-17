//
//  HomeViewModel.swift
//  Demo
//
//  Created by Pham Ngoc Hanh on 7/4/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation
import AtoneCon

final class HomeViewModel {

    var payment: AtoneCon.Payment {
        // TODO: dummy data
        var payment = AtoneCon.Payment(
            amount: 10,
            shopTransactionNo: "shop-tran-no-1499756055",
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
        let customer = AtoneCon.Customer(name: "接続テスト")
        return customer
    }

    // TODO: dummy data
    private var desCustomers: [AtoneCon.DesCustomer] {
        let descustomer = AtoneCon.DesCustomer(name: "銀座太郎", zipCode: "123-1234", address: "東京都中央区銀座１－１０ー６　銀座ファーストビル４階")
        return [descustomer]
    }

    // TODO: dummy data
    private var items: [AtoneCon.Item] {
        let item = AtoneCon.Item(id: "1", name: "１０円チョコ", price: 10, count: 1)
        return [item]
    }
}
