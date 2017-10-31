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
        public var publicKey: String
        public var terminalId: String?
        public var environment: Environment = .production
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
    }
}
