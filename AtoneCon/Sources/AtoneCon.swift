//
//  AtoneCon.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 6/30/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//
import Foundation
import ObjectMapper
import SAMKeychain

public protocol AtoneConDelegate: class {
    func atoneCon(atoneCon: AtoneCon, didReceivePaymentEvent event: AtoneCon.PaymentEvent)
}

final public class AtoneCon {

    // MARK: - Singleton
    public static let shared = AtoneCon()

    // MARK: - Properties
    internal var options: AtoneCon.Options?
    public weak var delegate: AtoneConDelegate?
    fileprivate var payment: Payment?

    // MARK: - Public Functions
    public func config(_ options: Options) {
        self.options = options
    }

    public func performPayment(_ payment: Payment) {
        guard let root = UIApplication.shared.delegate?.window??.rootViewController else { return }
        guard NetworkReachabilityManager()?.isReachable == true else {
            let error: [String: Any] = [Define.String.Key.title: Define.String.network,
                                        Define.String.Key.message: Define.String.Error.network]
            let event = PaymentEvent.failed(error)
            delegate?.atoneCon(atoneCon: self, didReceivePaymentEvent: event)
            return
        }
        self.payment = payment
        let paymentController = PaymentViewController(payment: payment)
        paymentController.delegate = self
        root.present(paymentController, animated: true, completion: nil)
    }

    public func dismiss(completion: (() -> Void)? = nil) {
        let root = UIApplication.shared.delegate?.window??.rootViewController
        root?.dismiss(animated: true, completion: completion)
    }

    public func resetAuthenToken() {
        Session.shared.clearCredential()
    }
}

extension AtoneCon {
    public enum PaymentEvent {
        case authenticated(String?, String?)
        case cancelled
        case finished([String: Any]?)
        case failed([String: Any]?)
    }
}

internal enum AtoneConError: Error {
    case option([String: Any]?)
    case payment([String: Any]?)
}

extension AtoneCon: PaymentViewControllerDelegate {
    func controller(_ controller: PaymentViewController, didReceiveScriptEvent event: ScriptEvent) {
        switch event {
        case .authenticated(let token, let userNo):
            delegate?.atoneCon(atoneCon: self, didReceivePaymentEvent: .authenticated(token, userNo))
        case .failed(let response):
            delegate?.atoneCon(atoneCon: self, didReceivePaymentEvent: .failed(response))
        case .cancelled:
            delegate?.atoneCon(atoneCon: self, didReceivePaymentEvent: .cancelled)
        case .succeeded(let response):
            delegate?.atoneCon(atoneCon: self, didReceivePaymentEvent: .finished(response))
        }
    }
}
