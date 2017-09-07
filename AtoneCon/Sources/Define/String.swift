//
//  Strings.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 7/4/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation

extension Define {
    internal class String {
        static let network = "network".localized()
        static let options = "options".localized()
        static let okay = "okay".localized()
        static let cancel = "cancel".localized()
        static let close = "close".localized()
        static let quitPayment = "quitPayment".localized()
        static let paymentInfo = "paymentInfo".localized()
        static let script = "scriptHandler".localized()
    }
}

extension Define.String {
    internal struct Image {
        static let close = "ic_close"
    }
}

extension Define.String {
    internal struct Key {
        static let loading = "loading"
    }
}

extension Define.String {
    internal struct Error {
        static let network = "networkError".localized()
        static let options = "configOptions".localized()
        static let payment = "payment".localized()
    }
}

extension String {
    internal func localized(_ comment: String = "") -> String {
        let bundle = Bundle(for: Define.String.self)
        return NSLocalizedString(self, bundle: bundle, comment: comment)
    }
}
