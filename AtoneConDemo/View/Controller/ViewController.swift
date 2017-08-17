//
//  ViewController.swift
//  AtoneConDemo
//
//  Created by Pham Ngoc Hanh on 6/28/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import UIKit
import AtoneCon

final class ViewController: UIViewController {

    @IBOutlet fileprivate weak var payButton: UIButton!
    @IBOutlet fileprivate weak var authenTokenTitleLabel: UILabel!
    @IBOutlet fileprivate weak var authenTokenValueLabel: UILabel!
    @IBOutlet fileprivate weak var authenTokenView: UIView!
    @IBOutlet fileprivate weak var resetTokenButton: UIButton!
    @IBOutlet fileprivate weak var transactionTextField: UITextField!

    var viewModel = PaymentViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        authenTokenValueLabel.text = viewModel.getAuthenToken()
        transactionTextField.text = ""
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    // MARK: - Setup UI
    private func setupUI() {
        title = Define.String.homeTitle
        setupPayButton()
        setupAuthenTokenView()
        setupAuthenTokenLabel()
        setupResetTokenButton()
        setupNavigationController()
        setupTextField()
    }

    // MARK: - Action
    @IBAction func payButtonTapped(_ sender: Any) {
        var options = AtoneCon.Options()
        // TODO: - dummy data
        options.publicKey = "bB2uNvcOP2o8fJzHpWUumA"
        options.environment = .development
        let atoneCon = AtoneCon.shared
        atoneCon.delegate = self
        atoneCon.config(options)
        // TODO: - dummy data
        let payment = viewModel.payment(withTransaction: transactionTextField.text)
        atoneCon.performPayment(payment)
    }
    @IBAction func resetTokenButtonTapped(_ sender: Any) {
        viewModel.resetAuthenToken()
        updateView()
    }
}

// MARK: - AtoneConDelegate
extension ViewController: AtoneConDelegate {
    func atoneCon(atoneCon: AtoneCon, didReceivePaymentEvent event: AtoneCon.PaymentEvent) {
        switch event {
        case .authenticated(let authenToken):
            viewModel.saveAuthenToken(token: authenToken)
        case .cancelled:
            atoneCon.dismiss { [weak self] in
                guard let this = self else { return }
                this.showAlert(title: Define.String.cancel, message: nil)
            }
        case .failed(let response):
            let message: String? = response?.description
            showAlert(title: Define.String.failed, message: message)
        case .finished(let response):
            let message = response?.description
            atoneCon.dismiss { [weak self] in
                guard let this = self else { return }
                this.showAlert(title: Define.String.finished, message: message)
            }
        }
    }
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}

// MARK: - setup UI
extension ViewController {
    fileprivate func showAlert(title: String?, message: String?, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: Define.String.okay, style: .cancel, handler: handler)
        alert.addAction(ok)
        let root = AppDelegate.shared.window?.topViewController
        root?.present(alert, animated: true, completion: nil)
    }

    fileprivate func setupPayButton() {
        payButton.layer.cornerRadius = 5
        payButton.backgroundColor = Define.Color.lightBlue
        payButton.setTitle(Define.String.atoneButtonTitle, for: .normal)
    }

    fileprivate func setupNavigationController() {
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.barTintColor = Define.Color.lightBlue
            navigationBar.tintColor = UIColor.white
            navigationBar.isTranslucent = false
            navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
            navigationBar.tintColor = UIColor.white
        }
    }

    fileprivate func setupAuthenTokenView() {
        authenTokenView.layer.borderWidth = 2
        authenTokenView.layer.borderColor = Define.Color.lightBlue.cgColor
        authenTokenView.layer.cornerRadius = 5
    }

    fileprivate func setupAuthenTokenLabel() {
        authenTokenTitleLabel.backgroundColor = .white
        authenTokenTitleLabel.text = Define.String.authenTokenTitle
        authenTokenTitleLabel.textColor = Define.Color.lightBlue
    }

    fileprivate func setupResetTokenButton() {
        let attributes: [String:Any] = [
            NSFontAttributeName: UIFont.systemFont(ofSize: 17),
            NSForegroundColorAttributeName: UIColor.black,
            NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]
        let attributedString: NSAttributedString = NSAttributedString(string: Define.String.resetAuthen, attributes: attributes)
        resetTokenButton.setAttributedTitle(attributedString, for: .normal)
    }

    fileprivate func setupTextField() {
        transactionTextField.placeholder = Define.String.textFieldPlaceHolder
        transactionTextField.delegate = self
    }

    fileprivate func updateView() {
        if isViewLoaded {
            authenTokenValueLabel.text = viewModel.getAuthenToken()
        }
    }
}

extension UIWindow {
    var topViewController: UIViewController? {
        return rootViewController?.visibleController
    }
}

extension UIViewController {
    var visibleController: UIViewController? {
        switch self {
        case let navi as UINavigationController:
            return navi.visibleViewController?.visibleController
        case let tabBar as UITabBarController:
            return tabBar.selectedViewController?.visibleController
        case let controller where self.presentedViewController != nil:
            return controller.presentedViewController?.visibleController
        default:
            return self
        }
    }
}
