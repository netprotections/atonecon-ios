//
//  AtoneCon.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 6/30/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import UIKit

final public class AtoneCon {
    // MARK: - Singleton
    public static let shared = AtoneCon()

    // MARK: - Properties
    private var option = Options()

    // MARK: - Public Functions
    public func config(_ option: Options) {
        // TODO: Config public key
        self.option = option
    }

    public func performPayment(_ payment: Payment) {
        // TODO: Need Implement Data To JS
        let paymenController = PaymentViewController()
        let root = UIApplication.shared.delegate?.window??.rootViewController
        root?.present(paymenController, animated: true, completion: nil)
    }
}
