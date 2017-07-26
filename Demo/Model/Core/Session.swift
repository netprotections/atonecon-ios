//
//  Session.swift
//  Demo
//
//  Created by Pham Ngoc Hanh on 7/25/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation
import SAMKeychain

final class Session {

    static let shared = Session()

    struct Credential {
        fileprivate let key = "accessToken"
        fileprivate(set) var value: String

        var isValid: Bool {
            return !value.isEmpty
        }
    }

    var credential = Credential(value: "") {
        didSet {
            saveCredential()
        }
    }

    private func saveCredential() {
        guard credential.isValid else { return }
        removeCredential()
        SAMKeychain.setPassword(credential.value, forService: Define.String.serviceName, account: credential.key)
    }

    func loadCredential() {
        guard let value = SAMKeychain.password(forService: Define.String.serviceName, account: credential.key) else { return }
        credential.value = value
    }

    func clearCredential() {
        credential.value = ""
        removeCredential()
    }

    private func removeCredential() {
        SAMKeychain.deletePassword(forService: Define.String.serviceName, account: credential.key)
    }
}
