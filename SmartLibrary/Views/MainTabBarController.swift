//
//  MainTabBarController.swift
//  SmartLibrary
//
//  Created by Кирилл Галимзянов on 27.02.2020.
//  Copyright © 2020 Kirill Galimzyanov. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class MainTabBarController: UITabBarController {

    var currentUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        let vc = self.viewControllers![0] as? ProfileNavigationController
        vc?.currentUser = currentUser
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
        }
    }
}
