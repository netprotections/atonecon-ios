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
    func atoneCon(atoneCon: AtoneCon, didReceivePaymentEvent event: AtoneCon.PaymentEvent)
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
        // TODO: Need Implement Data To JS
        delegate?.atoneCon(atoneCon: self, didReceivePaymentEvent: PaymentEvent.willPayment)
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
}

extension AtoneCon: PaymentViewControllerDelegate {
    func controller(_ controller: PaymentViewController, didReceiveScriptEvent event: ScriptEvent) {
        switch event {
            // TODO: save token
        case .authenticated(_):
            break
        case .failed(_):
            // TODO: Handle message error
            delegate?.atoneCon(atoneCon: self, didReceivePaymentEvent: PaymentEvent.failed(NSError()))
        case .canceled:
            if let payment = payment {
                delegate?.atoneCon(atoneCon: self, didReceivePaymentEvent: PaymentEvent.canceled(payment))
            }
        case .succeeded(_):
            // TODO: Handle succeeded
            if let payment = payment {
                delegate?.atoneCon(atoneCon: self, didReceivePaymentEvent: PaymentEvent.finished(payment, " "))
            }
        }
    }
}

extension AtoneCon {
    public enum PaymentEvent {
        case willPayment
        case canceled(AtoneCon.Payment)
        case finished(AtoneCon.Payment, String)
        case failed(NSError)
    }
}
