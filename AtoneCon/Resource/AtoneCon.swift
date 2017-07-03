//
//  AtoneCon.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 6/30/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation
import UIKit

public func performPayment(_ payment: Payment) {
    let paymenController = PaymentViewController()
    let root = UIApplication.shared.delegate?.window??.rootViewController
    root?.present(paymenController, animated: true, completion: nil)
}

// TODO: config public key
public func config(_ option: Options) {
}
