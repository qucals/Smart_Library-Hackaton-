//
//  GradientView.swift
//  SmartLibrary
//
//  Created by Кирилл Галимзянов on 03.03.2020.
//  Copyright © 2020 Kirill Galimzyanov. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    
    let gradientLayer = CAGradientLayer()
    
    @IBInspectable var firstColor: UIColor = UIColor.black
}
