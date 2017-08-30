//
//  Session.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 7/25/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation
import SAMKeychain

internal final class Session {

    internal static let shared = Session()
    private let service = "AtoneCon"

    internal struct Credential {
        fileprivate let key = "accessToken"
        fileprivate(set) var authToken: String?

        internal var isValid: Bool {
            guard let authToken = authToken else { return false }
            return !authToken.isEmpty
        }
    }

    internal var credential = Credential(authToken: "") {
        didSet {
            saveCredential()
        }
    }

    private func saveCredential() {
        guard credential.isValid else { return }
        removeCredential()
        let value = credential.authToken ?? ""
        SAMKeychain.setPassword(value, forService: service, account: credential.key)
    }

    internal func loadCredential() {
        guard let authToken = SAMKeychain.password(forService: service, account: credential.key) else { return }
        credential.authToken = authToken
    }

    internal func clearCredential() {
        credential.authToken = ""
        removeCredential()
    }

    private func removeCredential() {
        SAMKeychain.deletePassword(forService: service, account: credential.key)
    }
}
