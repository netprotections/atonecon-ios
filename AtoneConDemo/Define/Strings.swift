//
//  String.swift
//  AtoneConDemo
//
//  Created by Pham Ngoc Hanh on 6/29/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation

extension Define.Strings {
    static let homeTitle = "Atone".localized()
    static let resetAuthen = "resetAuthen".localized()
    static let authenTokenTitle = "authenTokenTitle".localized()
    static let atoneButtonTitle = "atoneButtonTitle".localized()
    static let tokenKey = "userToken"
    static let serviceName = "AtoneConWebView"
    static let textFieldPlaceHolder = "textFieldPlaceHolder".localized()
    static let baseTransaction = "shop-tran-no-"
    static let okay = "okay".localized()
    static let finished = "finished".localized()
    static let failed = "failed".localized()
    static let error = "error".localized()
}

extension String {
    internal func localized(_ comment: String = "") -> String {
        guard let identifier = Bundle.main.bundleIdentifier else { return self }
        guard let bundle = Bundle(identifier: identifier) else { return self }
        return NSLocalizedString(self, bundle: bundle, comment: comment)
    }
}
