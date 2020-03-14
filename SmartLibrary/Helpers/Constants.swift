//
//  Constants.swift
//  SmartLibrary
//
//  Created by Кирилл Галимзянов on 02.03.2020.
//  Copyright © 2020 Kirill Galimzyanov. All rights reserved.
//

import Foundation
import UIKit
import SwiftHEXColors

struct Constants {
    
    struct Storyboard {
        
        static let performSegueToHomeBC = "toHomeBC"
        static let performSegueToSelectedCell = "toDetailBook"
        
        static let cellIdentifier = "bookCell"
    }
    
    struct Colours {
        
        // Colours of main gradient
        static let firstColourGradient = UIColor(hexString: "#FFD692")!
        static let secondColourGradient = UIColor(hexString: "#E16363")!
        
        // Default colours
        static let stateColourTextField = UIColor.groupTableViewBackground
        static let errorColourTextField = UIColor(hexString: "#D63447")!
    }
    
    struct Firebase {
        
        static let pathToCollectionBooks = "books"
        static let pathToUsers = "users"
    }
}
