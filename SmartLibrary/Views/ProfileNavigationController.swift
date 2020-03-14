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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = self.topViewController as? ProfileViewController
        vc?.currentUser = currentUser
    }
}
