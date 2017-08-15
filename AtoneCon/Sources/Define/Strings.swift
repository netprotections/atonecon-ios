//
//  Strings.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 7/4/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation

extension Define {
    internal class Strings {
        static let network = "network".localized()
        static let okay = "okay".localized()
        static let cancel = "cancel".localized()
        static let close = "close".localized()
        static let quitPayment = "quitPayment".localized()
    }
}

extension Define.Strings {
    internal struct Error {
        static let network = "networkError".localized()
    }
}

extension String {
    internal func localized(_ comment: String = "") -> String {
        let bundle = Bundle(for: Define.Strings.self)
        return NSLocalizedString(self, bundle: bundle, comment: comment)
    }
}
