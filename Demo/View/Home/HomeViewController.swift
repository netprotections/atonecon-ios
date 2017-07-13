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
    @IBOutlet private weak var authentokenTitleLabel: UILabel!
    @IBOutlet private weak var authentokenValueLabel: UILabel!
    @IBOutlet private weak var authentokenView: UIView!
    @IBOutlet private weak var resetTokenButton: UIButton!
    fileprivate var authentoken: String? {
        didSet {
            authentokenValueLabel.text = authentoken
        }
    }

    var viewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        let yourAttributes: [String:Any] = [
            NSFontAttributeName: UIFont.systemFont(ofSize: 17),
            NSForegroundColorAttributeName: UIColor.black,
            NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]
        title = Define.String.homeTitle
        payButton.layer.cornerRadius = 5
        payButton.backgroundColor = Define.Color.lightBlue
        navigationController?.navigationBar.barTintColor = Define.Color.lightBlue
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        authentokenView.layer.borderWidth = 2
        authentokenView.layer.borderColor = Define.Color.lightBlue.cgColor
        authentokenTitleLabel.backgroundColor = .white
        authentokenTitleLabel.text = Define.String.authenTokenTitle
        authentokenTitleLabel.textColor = Define.Color.lightBlue
        authentokenView.layer.cornerRadius = 5
        let attributedString: NSAttributedString = NSAttributedString(string: Define.String.resetAuthen, attributes: yourAttributes)
        resetTokenButton.setAttributedTitle(attributedString, for: .normal)
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

    @IBAction func resetTokenButtonTapped(_ sender: Any) {
        authentoken = ""
    }
}

extension HomeViewController: AtoneConDelegate {

    func atoneCon(atoneCon: AtoneCon, didReceivePaymentEvent event: AtoneCon.PaymentEvent) {
        switch event {
        case .willPayment(_):
            break
        case .failed(_):
            // TODO: handle failed
            atoneCon.dismissWebview()
        case .cancelled():
            // TODO: handle canceled
            atoneCon.dismissWebview()
        case .finished(_, _):
            // TODO: handle finished
            atoneCon.dismissWebview()
        }
    }
}
