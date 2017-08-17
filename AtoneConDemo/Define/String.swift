//
//  String.swift
//  AtoneConDemo
//
//  Created by Pham Ngoc Hanh on 6/29/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation

extension Define.String {
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
    static let cancel = "cancel".localized()
}

extension String {
    internal func localized(_ comment: String = "") -> String {
        return NSLocalizedString(self, bundle: Bundle.main, comment: comment)
    }
}
