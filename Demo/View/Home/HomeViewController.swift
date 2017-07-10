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

    var viewModel = HomeViewModel()
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
        atoneCon.delegate = self
        // TODO: - dummy data
        let payment = viewModel.payment
        atoneCon.performPayment(payment)
    }
}

extension HomeViewController: AtoneConDelegate {

    func atoneCon(atoneCon: AtoneCon, didPerformAction action: Action) {
        switch action {
        case .payment(let payment):
            print(payment)
        case .failed(let error):
            print(error)
        case .canceled(let payment):
            print(payment)
        case .finished(let payment, let transactionId):
            print(payment)
            print(transactionId)
        }
    }
}
