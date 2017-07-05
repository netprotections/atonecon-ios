//
//  HomeViewModel.swift
//  Demo
//
//  Created by Pham Ngoc Hanh on 7/4/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation
import AtoneCon

final internal class HomeViewModel {

    private var payment: AtoneCon.Payment {
        // TODO: dummy data
        var payment = AtoneCon.Payment(
            amount: 0,
            shopTransactionNo: "",
            salesSettled: true,
            descriptionTrans: "",
            checksum: "")

        payment.customer = customer
        payment.desCustomers = desCustomers
        payment.items = items
        return payment
    }

    // TODO: dummy data
    private var customer: AtoneCon.Customer {
        return AtoneCon.Customer(
            name: "",
            familyName: "",
            givenName: "",
            nameKana: "",
            familyNameKana: "",
            givenNameKana: "",
            phoneNumber: "",
            birthday: "",
            sexDivision: "",
            companyName: "",
            department: "",
            zipCode: "",
            address: "",
            tel: "",
            email: "",
            totalPurchaseCount: 0,
            totalPurchaseAmount: 0)
    }

    // TODO: dummy data
    private var desCustomers: [AtoneCon.DesCustomer] {
        return [
            AtoneCon.DesCustomer(
                name: "",
                nameKana: "",
                companyName: "",
                department: "",
                zipCode: "",
                address: "",
                tel: "",
                email: "")
        ]
    }

    // TODO: dummy data
    private var items: [AtoneCon.Item] {
        return [
            AtoneCon.Item(
                id: "1",
                name: "",
                price: 0,
                count: 0,
                url: ""),
            AtoneCon.Item(
                id: "2",
                name: "",
                price: 0,
                count: 0,
                url: "")
        ]
    }

    internal func getPayment() -> AtoneCon.Payment {
        return payment
    }
}
