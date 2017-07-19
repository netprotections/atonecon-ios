//
//  AtoneCon.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 6/30/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//
import Foundation
import ObjectMapper

public protocol AtoneConDelegate: class {
    func atoneCon(atoneCon: AtoneCon, didReceiveScriptEvent event: ScriptEvent)
}

final public class AtoneCon {

    // MARK: - Singleton
    public static let shared = AtoneCon()

    // MARK: - Properties
    private var option = Options()
    public weak var delegate: AtoneConDelegate?
    fileprivate var payment: Payment?

    // MARK: - Public Functions
    public func config(_ option: Options) {
        // TODO: Config public key
        self.option = option
    }

    public func performPayment(_ payment: Payment) {
        self.payment = payment
        let paymenController = PaymentViewController(payment: payment)
        paymenController.delegate = self
        let root = UIApplication.shared.delegate?.window??.rootViewController
        root?.present(paymenController, animated: true, completion: nil)
    }

    public func dismissWebview() {
        let root = UIApplication.shared.delegate?.window??.rootViewController
        root?.dismiss(animated: true, completion: nil)
    }

    public func resetAuthenToken() {
        UserDefaults.standard.removeObject(forKey: Define.String.tokenKey)
    }
}

extension AtoneCon: PaymentViewControllerDelegate {
    func controller(_ controller: PaymentViewController, didReceiveScriptEvent event: ScriptEvent) {
        delegate?.atoneCon(atoneCon: self, didReceiveScriptEvent: event)
    }
}
