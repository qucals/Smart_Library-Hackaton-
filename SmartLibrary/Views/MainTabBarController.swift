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
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let vc_1 = self.viewControllers![0] as? ProfileNavigationController
        vc_1?.currentUser = currentUser
        vc_1?.rootViewController = self
        
        let vc_2 = self.viewControllers![1] as? LibraryNavigationController
        vc_2?.currentUser = currentUser
        vc_2?.rootViewController = self
        
        let vc_3 = self.viewControllers![2] as? EventsNavigationController
        vc_3?.currentUser = currentUser
        vc_3?.rootViewController = self
        
        let vc_4 = self.viewControllers![3] as? MapNavigationController
        vc_4?.currentUser = currentUser
        vc_4?.rootViewController = self
    }
}
