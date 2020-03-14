//
//  BookImage.swift
//  SmartLibrary
//
//  Created by Кирилл Галимзянов on 13.03.2020.
//  Copyright © 2020 Kirill Galimzyanov. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class BookImage: UIImageView {
    
    @IBInspectable var shadowColor: CGColor? {
        set { self.layer.shadowColor = newValue }
        get { return self.layer.shadowColor }
    }
    
    @IBInspectable var shadowOpacity: Float {
        set { self.layer.shadowOpacity = newValue }
        get { return self.layer.shadowOpacity }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        set { self.layer.shadowRadius = newValue }
        get { return self.layer.shadowRadius }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        set { self.layer.shadowOffset = newValue }
        get { return self.layer.shadowOffset }
    }
}
