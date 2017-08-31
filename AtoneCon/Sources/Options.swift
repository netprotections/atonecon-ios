//
//  Options.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 7/3/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation

extension AtoneCon {
    public struct Options {
        public var publicKey = ""
        public var environment: Environment = .development
        public init(publicKey: String) {
            self.publicKey = publicKey
        }
    }
}

extension AtoneCon {
    public enum Environment {
        case development
        case production
        case staging

        var JSUrl: String {
            switch self {
            case .development:
                return "https://it-auth.a-to-ne.jp/v1/atone.js"
            case .production:
                return "https://auth.atone.be/v1/atone.js"
            case .staging:
                return "https://it-auth.a-to-ne.jp/v1/atone.js"
            }
        }
    }
}
