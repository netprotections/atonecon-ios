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
        fileprivate(set) var value: String?

        var isValid: Bool {
            guard let value = value else { return false }
            return !value.isEmpty
        }
    }

    internal var credential = Credential(value: "") {
        didSet {
            saveCredential()
        }
    }

    private func saveCredential() {
        guard credential.isValid else { return }
        removeCredential()
        guard let value = credential.value else { return }
        SAMKeychain.setPassword(value, forService: serviceName, account: credential.key)
    }

    internal func loadCredential() {
        guard let value = SAMKeychain.password(forService: serviceName, account: credential.key) else { return }
        credential.value = value
    }

    internal func clearCredential() {
        credential.value = ""
        removeCredential()
    }

    private func removeCredential() {
        SAMKeychain.deletePassword(forService: serviceName, account: credential.key)
    }
}
