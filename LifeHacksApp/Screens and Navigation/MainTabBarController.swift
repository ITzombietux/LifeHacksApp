//
//  MainTabBarController.swift
//  LifeHacksApp
//
//  Created by zombietux on 10/01/2019.
//  Copyright © 2019 zombietux. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, Stateful {
   
    var stateController: StateController? = StateController()
    var settingsController: SettingsController?
    var uploadNotificationCenter: NotificationCenter?
    
    override func viewDidLoad() {
        guard let viewControllers = viewControllers else {
            return
        }
        for case let navigationController as UINavigationController in viewControllers {
            if let rootViewController = navigationController.viewControllers.first as? Stateful {
                passState(to: rootViewController)
            }
        }
        uploadNotificationCenter?.addObserver(forName: UploadNotification.completed.name, object: nil, queue: .main) { [weak self] _ in
            let alertController = UIAlertController(title: "Upload completed", message: nil, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self?.present(alertController, animated: true, completion: nil)
        }
    }
}
