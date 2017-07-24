//
//  AppDelegate.swift
//  AtoneConDemo
//
//  Created by Mylo Ho on 6/28/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import UIKit
import AtoneCon

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let homeController = HomeViewController()
        let navi = UINavigationController(rootViewController: homeController)
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            window.rootViewController = navi
            window.backgroundColor = .white
            window.makeKeyAndVisible()
        }
        return true
    }
}
