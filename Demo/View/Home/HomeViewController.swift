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

    func atoneCon(atoneCon: AtoneCon, needsPerformAction action: AtoneCon.Action) {
        // TODO: Handle Callback
        switch action {
        case .willPayment(let payment):
            break
        case .failed(let error):
            // TODO: get respone
            atoneCon.dismissWebview()
        case .canceled(let payment):
            // TODO: get respone
            atoneCon.dismissWebview()
        case .finished(let payment, let transactionId):
            // TODO: get respone
            atoneCon.dismissWebview()
        }
    }
}
