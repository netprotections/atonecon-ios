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
        static let network = "Network"
        static let okay = "OK"
        static let cancel = "Cancel".localized()
        static let close = "Close".localized()
        static let quitPayment = "QuitPayment".localized()
    }
}

extension Define.Strings {
    internal struct Error {
        static let network = "Network".localized()
    }
}

extension String {
    internal func localized(_ comment: String = "") -> String {
        let bundle = Bundle(for: Define.Strings.self)
        return NSLocalizedString(self, bundle: bundle, comment: comment)
    }
}
