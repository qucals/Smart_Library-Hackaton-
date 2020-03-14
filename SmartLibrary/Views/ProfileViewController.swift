//
//  ProfileViewController.swift
//  SmartLibrary
//
//  Created by Кирилл Галимзянов on 12.03.2020.
//  Copyright © 2020 Kirill Galimzyanov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var currentUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = currentUser.title
        emailLabel.text = currentUser.phone
    }
    
    @IBAction func accountTapped(_ sender: Any) {
    }
    
    @IBAction func notificationsTapped(_ sender: Any) {
    }
    
    @IBAction func privacyTapped(_ sender: Any) {
    }
    
    @IBAction func logOutTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
