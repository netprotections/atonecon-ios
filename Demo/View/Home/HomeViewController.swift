//
//  HomeViewController.swift
//  Demo
//
//  Created by Pham Ngoc Hanh on 6/28/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import UIKit
import AtoneCon

class HomeViewController: UIViewController {

    @IBOutlet private weak var payButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        title = Strings.homeTitle
        payButton.layer.cornerRadius = 10
    }

    // MARK: - Action
    @IBAction func payButtonTapped(_ sender: Any) {
        var options = AtonePay.Options()
        // TODO: - dummy data
        options.publicKey = "xx-yy-zz"
        AtonePay.config(options)
        let payment = AtonePay.Payment()
        
        AtonePay.performPayment(payment)
    }
}
