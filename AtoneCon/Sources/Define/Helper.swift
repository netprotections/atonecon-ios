//
//  Helper.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 8/1/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation
import  UIKit

extension Define {
    internal struct Helper {}
}

extension Define.Helper {
    internal enum DeviceType {
        case iPhone4
        case iPhone5
        case iPhone6
        case iPhone6p
        case iPad

        public var size: CGSize {
            switch self {
            case .iPhone4: return CGSize(width: 320, height: 480)
            case .iPhone5: return CGSize(width: 320, height: 568)
            case .iPhone6: return CGSize(width: 375, height: 667)
            case .iPhone6p: return CGSize(width: 414, height: 736)
            case .iPad: return CGSize(width: 768, height: 1_024)
            }
        }
    }

    internal struct Ratio {
        static let vertical = UIScreen.main.bounds.height / CGFloat(DeviceType.iPhone6.size.height)
        static let horizontal = UIScreen.main.bounds.width / CGFloat(DeviceType.iPhone6.size.width)
    }
}

extension Bundle {
    static var current: Bundle {
        var current: Bundle = Bundle(for: AtoneCon.self)
        let bundleURL = current.url(forResource: "AtoneCon", withExtension: "bundle")
        if let bundle = bundleURL, let currentBundle = Bundle(url: bundle) {
            current = currentBundle
        }
        return current
    }
}
