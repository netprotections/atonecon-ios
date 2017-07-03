//
//  AtonePay.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 6/30/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation
import UIKit

public final class AtoneCon {

    public struct Options {
        public var publicKey = ""

        public init() {
        }
    }

    public class func performPayment(_ payment: Payment) {
        let paymenController = PaymentViewController()
        let root = UIApplication.shared.delegate?.window??.rootViewController
        root?.present(paymenController, animated: true, completion: nil)
    }

    public class func config(_ option: Options) {

    }

}
