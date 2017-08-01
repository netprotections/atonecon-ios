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
    internal struct IPhoneSize {
        static let IP6PlusScreenHeight = 736.0
        static let IP6ScreenHeight = 667.0
        static let IP5ScreenHeight = 568.0
        static let IP4ScreenHeight = 480.0

        static let IP6PlusScreenWidth = 410.0
        static let IP6ScreenWidth = 375.0
        static let IP5ScreenWidth = 320.0
        static let IP4ScreenWidth = 320.0
    }
}

extension Define.Helper {
    internal struct ScreenSize {
        static let screenWidth = UIScreen.main.bounds.width
        static let screenHeight = UIScreen.main.bounds.height
    }
}

extension Define.Helper {
    internal struct Ratio {
        static let vertical = ScreenSize.screenHeight / CGFloat(IPhoneSize.IP6ScreenHeight)
        static let horizontal = ScreenSize.screenWidth / CGFloat(IPhoneSize.IP6ScreenWidth)
    }
}
