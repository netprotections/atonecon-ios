//
//  AppDelegate.swift
//  AtoneConDemo
//
//  Created by Pham Ngoc Hanh on 6/28/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import UIKit
import AtoneCon

let userDefault = UserDefaults.standard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    class var shared: AppDelegate {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("App Delegate Error")
        }
        return delegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let controller = ViewController()
        let navi = UINavigationController(rootViewController: controller)
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            window.rootViewController = navi
            window.backgroundColor = .white
            window.makeKeyAndVisible()
        }
        return true
    }
}
