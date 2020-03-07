//
//  MainTabBarController.swift
//  SmartLibrary
//
//  Created by Кирилл Галимзянов on 27.02.2020.
//  Copyright © 2020 Kirill Galimzyanov. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {

    var email: String?
    var password: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let viewControllers = viewControllers else {
            return
        }
        
        for viewController in viewControllers {
            if let profileNavigationController = viewController as? ProfileNavigationController {
                if let profileViewController = profileNavigationController.viewControllers.first as? ProfileViewController {
                    profileViewController.email = email
                    profileViewController.password = password
                }
            }
        }
    }
    
}
