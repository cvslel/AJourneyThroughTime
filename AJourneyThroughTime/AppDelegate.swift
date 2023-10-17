//
//  AppDelegate.swift
//  AJourneyThroughTime
//
//  Created by Cenker Soyak on 17.10.2023.
//

import UIKit
import RevenueCat

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        window?.makeKeyAndVisible()
        Purchases.configure(withAPIKey: "appl_bVveSVipMxOstwKjEEYMFOKAZAF")
        return true
    }
}

