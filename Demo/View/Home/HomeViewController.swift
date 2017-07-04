//
//  HomeViewController.swift
//  Demo
//
//  Created by Pham Ngoc Hanh on 6/28/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import UIKit
import AtoneCon

final class HomeViewController: UIViewController {

    @IBOutlet private weak var payButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        title = Define.String.homeTitle
        payButton.layer.cornerRadius = 10
    }

    // MARK: - Action
    @IBAction func payButtonTapped(_ sender: Any) {
        var options = AtoneCon.Options()
        // TODO: - dummy data
        options.publicKey = "xx-yy-zz"

        let atoneCon = AtoneCon.shared
        atoneCon.config(options)

        // TODO: - dummy data
        var payment = AtoneCon.Payment(
            amount: 123,
            shopTransactionNo: "",
            salesSettled: true,
            descriptionTrans: "",
            checksum: "Eba8b4JtD+inOc/zRON0D4RfODMfXwsz1hCdAmrq1CI="
        )

        payment.customer = AtoneCon.Customer(
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
            totalPurchaseAmount: 0
        )

        payment.desCustomers = [
            AtoneCon.DesCustomer(
                name: "",
                nameKana: "",
                companyName: "",
                department: "",
                zipCode: "",
                address: "",
                tel: "",
                email: ""
            )
        ]

        payment.items = [
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

        atoneCon.performPayment(payment)
    }
}
