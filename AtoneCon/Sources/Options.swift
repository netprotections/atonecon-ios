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
        public var environment: EnvironmentType = .development
        public init() {}
    }
}

extension AtoneCon {
    public enum EnvironmentType {
        case development
        case release
        case staging
    }
}
