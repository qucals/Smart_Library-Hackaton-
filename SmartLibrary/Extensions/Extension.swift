//
//  Extension.swift
//  SmartLibrary
//
//  Created by Кирилл Галимзянов on 25.02.2020.
//  Copyright © 2020 Kirill Galimzyanov. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    @discardableResult
    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        
        return self.applyGradient(colours: colours, locations: nil)
    }
    
    @discardableResult
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        
        self.layer.insertSublayer(gradient, at: 0)
        
        return gradient
    }
}

extension UIViewController {
    
    func setGradientBackground(colours: [UIColor]) {
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = colours.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.frame
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func changeColourTextField(_ textField: RoundTextField, _ colour: UIColor) {
     
        textField.borderColor = colour
    }
}
