//
//  Extensions.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 8/10/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation

extension Dictionary where Key == String, Value == Any {
    static func error(name: String, title: String) -> [String: Any] {
        return ["name": name, "title": title]
    }
}
