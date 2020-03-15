//
//  LibraryNavigationController.swift
//  SmartLibrary
//
//  Created by Кирилл Галимзянов on 12.03.2020.
//  Copyright © 2020 Kirill Galimzyanov. All rights reserved.
//

import UIKit

class LibraryNavigationController: UINavigationController {

    var currentUser: User!
    
    var rootViewController: MainTabBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let vc = self.topViewController as? LibraryTableViewController
        vc?.currentUser = currentUser
        vc?.rootViewController = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        rootViewController.currentUser = currentUser
    }
}
