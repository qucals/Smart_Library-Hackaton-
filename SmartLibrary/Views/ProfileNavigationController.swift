//
//  ProfileNavigationController.swift
//  SmartLibrary
//
//  Created by Кирилл Галимзянов on 01.03.2020.
//  Copyright © 2020 Kirill Galimzyanov. All rights reserved.
//

import Foundation
import UIKit

class ProfileNavigationController: UINavigationController {
    
    var currentUser: User!
    
    var rootViewController: MainTabBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let vc = self.topViewController as? ProfileViewController
        vc?.currentUser = currentUser
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        rootViewController.currentUser = currentUser
    }
}
