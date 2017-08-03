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
        public init() {}
    }
}

extension AtoneCon {
    public enum Environment {
        case development
        case production
        case staging
    }
}
