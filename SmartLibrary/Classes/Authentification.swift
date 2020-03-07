//
//  Authentification.swift
//  SmartLibrary
//
//  Created by Кирилл Галимзянов on 25.02.2020.
//  Copyright © 2020 Kirill Galimzyanov. All rights reserved.
//

import Foundation
import UIKit

class Auth {
    init(username user: inout @IBOutlet UITextField, password pass: inout @IBOutlet UITextField) {
        self.user = user
        self.pass = pass
    }
    
    private func canLogIn() -> Bool {
        
    }
}
