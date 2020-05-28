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
            amount: 12460,
            shopTransactionNo: "",
            checksum: "Eba8b4JtD+inOc/zRON0D4RfODMfXwsz1hCdAmrq1CI=")
        payment.salesSettled = false
        payment.descriptionTrans = "備考です。"
        payment.transactionOptions = [3]
        payment.userNo = "user_no-1509419147"
        payment.customer = customer
        payment.desCustomers = desCustomers
        payment.items = items
        payment.serviceSupplier = supplier
        return payment
    }

    // TODO: dummy data
    private var customer: AtoneCon.Customer {
        var customer = AtoneCon.Customer(name: "注文太郎")
        customer.familyName = "注文"
        customer.givenName = "太郎"
        customer.nameKana = "ちゅうもんたろう"
        customer.familyNameKana = "ちゅうもん"
        customer.givenNameKana = "たろう"
        customer.sexDivision = "1"
        customer.companyName = "ネットプロテクションズ"
        customer.department = "セールス"
        customer.zipCode = "123-4567"
        customer.address = "東京都中央区銀座１－１０ー６　銀座ファーストビル４階"
        customer.tel = "+813-1234-1234"
        customer.email = "no@netprotections.co.jp"
        customer.birthday = "1990-01-01"
        customer.phoneNumber = "+8190-1111-1111"
        customer.totalPurchaseAmount = 2160
        customer.totalPurchaseCount = 8
        customer.identificationStatus = [1,3]
        customer.pastMerchandiseCategory = [["レディース", "ファッション小物", "手袋"]]
        customer.pastBrandName = ["エルメス"]
        customer.pastPaymentWay = [1, 5]
        customer.terminalId = "123456ABCDEFG"
        return customer
    }
    
    private var supplier: AtoneCon.Supplier {
        var supplier = AtoneCon.Supplier(shopCustomerId: "123456ABCDEFG")
        supplier.membershipPeriod = 30
        supplier.identificationStatus = [1, 3]
        supplier.totalSalesCount = 2
        supplier.totalSalesAmount = 2160
        supplier.pastMerchandiseCategory = [["レディース", "ファッション小物", "手袋"]]
        return supplier
    }

    // TODO: dummy data
    private var desCustomers: [AtoneCon.DesCustomer] {
        var desCustomer = AtoneCon.DesCustomer(name: "銀座太郎", zipCode: "123-1234", address: "東京都中央区銀座１－１０ー６　銀座ファーストビル４階")
        desCustomer.nameKana = "ぎんざたろう"
        desCustomer.companyName = "株式会社ネットプロテクションズ"
        desCustomer.department = "システム部門"
        desCustomer.tel = "0312341234"
        desCustomer.address = "東京都中央区銀座１−１３−１５　ダイワロイヤル銀座ビル　オフィスフロア　３階"
        desCustomer.zipCode = "123-1234"
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
