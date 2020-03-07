//
//  ProfileViewController.swift
//  SmartLibrary
//
//  Created by Кирилл Галимзянов on 01.03.2020.
//  Copyright © 2020 Kirill Galimzyanov. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    var email: String?
    var password: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tappedLogOut(_ sender: Any) {
        
        try! Auth.auth().signOut()
        self.dismiss(animated: true, completion: nil)
    }
}
