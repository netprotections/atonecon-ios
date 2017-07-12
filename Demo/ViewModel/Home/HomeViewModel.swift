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
            salesSettled: false,
            descriptionTrans: "備考です。",
            checksum: "iq4gHR9I8LTszpozjDIaykNjuIsYg+m/pR6JFKggr5Q=")

        payment.customer = customer
        payment.desCustomers = desCustomers
        payment.items = items
        return payment
    }

    // TODO: dummy data
    private var customer: AtoneCon.Customer {
        return AtoneCon.Customer(
            name: "接続テスト",
            familyName: nil,
            givenName: nil,
            nameKana: "セツゾクテスト",
            familyNameKana: nil,
            givenNameKana: nil,
            phoneNumber: nil,
            birthday: nil,
            sexDivision: nil,
            companyName: "（株）ネットプロテクションズ",
            department: "セールスグループ",
            zipCode: "1234567",
            address: "東京都中央区銀座１－１０ー６　銀座ファーストビル４階",
            tel: "080-1234-1234",
            email: "np@netprotections.co.jp",
            totalPurchaseCount: 20000,
            totalPurchaseAmount: 2)
    }

    // TODO: dummy data
    private var desCustomers: [AtoneCon.DesCustomer] {
        return [
            AtoneCon.DesCustomer(
                name: "銀座太郎",
                nameKana: "ぎんざたろう",
                companyName: "株式会社ネットプロテクションズ",
                department: "システム部門",
                zipCode: "123-1234",
                address: "東京都中央区銀座１－１０ー６　銀座ファーストビル４階",
                tel: "0312341234",
                email: "")
        ]
    }

    // TODO: dummy data
    private var items: [AtoneCon.Item] {
        return [
            AtoneCon.Item(
                id: "1",
                name: "１０円チョコ",
                price: 10,
                count: 1,
                url: "https://atone.be/items/1")
        ]
    }
}
