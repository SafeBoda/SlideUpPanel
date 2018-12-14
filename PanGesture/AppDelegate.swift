//
//  AppDelegate.swift
//  PanGesture
//
//  Created by ali ziwa on 12/12/2018.
//  Copyright © 2018 ali ziwa. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
//        let pulley = PulleyViewController(contentViewController: HomeViewController(), drawerViewController: ContentViewController())
//        pulley.animationSpringDamping = 3.0
//        pulley.initialDrawerPosition = .partiallyRevealed
//        pulley.snapMode = .nearestPosition
        window?.rootViewController = MyViewController()
        window?.makeKeyAndVisible()
        return true
    }
}
