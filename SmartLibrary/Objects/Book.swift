//
//  Book.swift
//  SmartLibrary
//
//  Created by Кирилл Галимзянов on 12.03.2020.
//  Copyright © 2020 Kirill Galimzyanov. All rights reserved.
//

import Foundation
import UIKit

class Book {
    
    let name: String
    let description: String
    let image: UIImage?
    let rating: CGFloat
    let available: Bool
    
    init?(name: String, description: String, image: UIImage?, rating: CGFloat, available: Bool) {
        guard name.count > 0 || description.count > 0 else {
            return nil
        }
        guard rating >= rating * (-1) else {
            return nil
        }
        
        self.name = name
        self.description = description
        self.image = image
        self.rating = rating
        self.available = available
    }
}
