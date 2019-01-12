//
//  UINavigationBar.swift
//  LifeHacksApp
//
//  Created by zombietux on 10/01/2019.
//  Copyright © 2019 zombietux. All rights reserved.
//
import UIKit

extension UINavigationBar {
    static func setCustomAppearance() {
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = .wedgewood
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
