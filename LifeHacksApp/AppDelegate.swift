//
//  AppDelegate.swift
//  LifeHacksApp
//
//  Created by zombietux on 01/12/2018.
//  Copyright © 2018 zombietux. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var stateController = StateController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.setCustomAppearance()
        if let initialViewController = window?.rootViewController as? Stateful {
            initialViewController.stateController = stateController
        }
        return true
    }
}
