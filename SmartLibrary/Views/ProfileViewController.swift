//
//  ProfileViewController.swift
//  SmartLibrary
//
//  Created by Кирилл Галимзянов on 12.03.2020.
//  Copyright © 2020 Kirill Galimzyanov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func acoountTapped(_ sender: Any) {
    }
    
    @IBAction func notificationsTapped(_ sender: Any) {
    }
    
    @IBAction func privacyTapped(_ sender: Any) {
    }
    
    @IBAction func logOutTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
