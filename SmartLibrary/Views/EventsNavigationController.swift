//
//  EventsNavigationController.swift
//  SmartLibrary
//
//  Created by Кирилл Галимзянов on 15.03.2020.
//  Copyright © 2020 Kirill Galimzyanov. All rights reserved.
//

import UIKit

class EventsNavigationController: UINavigationController {

    var currentUser: User!
    var rootViewController: MainTabBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        rootViewController.currentUser = currentUser
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let vc = self.topViewController as? EventsTableViewController {
            vc.currentUser = currentUser
            vc.rootViewController = self
        }
    }

}
