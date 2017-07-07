//
//  Optional.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 7/7/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation

extension Optional {
    func asStringOrNullText() -> String {
        switch self {
        case .some(let value):
            return String(describing: value)
        case _:
            return "null"
        }
    }
}
