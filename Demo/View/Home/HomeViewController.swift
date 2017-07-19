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
    @IBOutlet private weak var authenTokenTitleLabel: UILabel!
    @IBOutlet private weak var authenTokenValueLabel: UILabel!
    @IBOutlet private weak var authenTokenView: UIView!
    @IBOutlet private weak var resetTokenButton: UIButton!

    var viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        authenTokenValueLabel.text = viewModel.getAuthenToken()
    }

    private func setupUI() {
        title = Define.String.homeTitle
        setupPayButton()
        setupAuthenTokenView()
        setupAuthenTokenLabel()
        setupResetTokenButton()
        setupNavigationController()
    }

    private func setupPayButton() {
        payButton.layer.cornerRadius = 5
        payButton.backgroundColor = Define.Color.lightBlue
        payButton.setTitle(Define.String.atoneButtonTitle, for: .normal)
    }

    private func setupNavigationController() {
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.barTintColor = Define.Color.lightBlue
            navigationBar.tintColor = UIColor.white
            navigationBar.isTranslucent = false
            navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
            navigationBar.tintColor = UIColor.white
        }
    }

    private func setupAuthenTokenView() {
        authenTokenView.layer.borderWidth = 2
        authenTokenView.layer.borderColor = Define.Color.lightBlue.cgColor
        authenTokenView.layer.cornerRadius = 5
    }

    private func setupAuthenTokenLabel() {
        authenTokenTitleLabel.backgroundColor = .white
        authenTokenTitleLabel.text = Define.String.authenTokenTitle
        authenTokenTitleLabel.textColor = Define.Color.lightBlue
    }

    private func setupResetTokenButton() {
        let attributes: [String:Any] = [
            NSFontAttributeName: UIFont.systemFont(ofSize: 17),
            NSForegroundColorAttributeName: UIColor.black,
            NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]
        let attributedString: NSAttributedString = NSAttributedString(string: Define.String.resetAuthen, attributes: attributes)
        resetTokenButton.setAttributedTitle(attributedString, for: .normal)
    }

    // MARK: - Action
    @IBAction func payButtonTapped(_ sender: Any) {
        var options = AtoneCon.Options()
        // TODO: - dummy data
        options.publicKey = "bB2uNvcOP2o8fJzHpWUumA"

        let atoneCon = AtoneCon.shared
        atoneCon.delegate = self
        atoneCon.config(options)
        // TODO: - dummy data
        let payment = viewModel.payment
        atoneCon.performPayment(payment)
    }

    @IBAction func resetTokenButtonTapped(_ sender: Any) {
        viewModel.resetAuthenToken()
        updateView()
    }

    private func updateView() {
        if isViewLoaded {
            authenTokenValueLabel.text = viewModel.getAuthenToken()
        }
    }
}

extension HomeViewController: AtoneConDelegate {
    func atoneCon(atoneCon: AtoneCon, didReceiveScriptEvent event: ScriptEvent) {
        switch event {
        case .authenticated(let authenToken):
            guard let authenToken = authenToken else {
                fatalError("Don't received authenToken")
            }
            viewModel.saveAuthenToken(token: authenToken)
        case .failed(let response):
            guard let response = response else {
                fatalError("Don't received response")
            }
            print(response)
            atoneCon.dismissWebview()
        case .cancelled():
            atoneCon.dismissWebview()
        case .succeeded(let response):
            guard let response = response else {
                fatalError("Don't received response")
            }
            print(response)
            atoneCon.dismissWebview()
        }
    }
}
