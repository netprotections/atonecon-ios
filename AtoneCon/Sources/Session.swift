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
    }

    internal var credential = Credential(value: "") {
        didSet {
            saveCredential()
        }
    }

    private func saveCredential() {
        guard let value = credential.value else {
            credential.value = ""
            return
        }
        if !value.isEmpty {
            removeCredential()
            SAMKeychain.setPassword(value, forService: service, account: credential.key)
        }
    }

    internal func loadCredential() {
        guard let value = SAMKeychain.password(forService: service, account: credential.key) else { return }
        credential.value = value
    }

    internal func clearCredential() {
        credential.value = ""
        removeCredential()
    }

    private func removeCredential() {
        SAMKeychain.deletePassword(forService: service, account: credential.key)
    }
}
