//
//  BlurImageView.swift
//  SmartLibrary
//
//  Created by Кирилл Галимзянов on 14.03.2020.
//  Copyright © 2020 Kirill Galimzyanov. All rights reserved.
//

import Foundation
import VisualEffectView

class BlurImageView: UIImageView {
    lazy var visualEffectView: VisualEffectView = { [unowned self] in
        let view = VisualEffectView()
        self.addSubview(view)
        return view
    }()
}

extension VisualEffectView {
    func tint(_ color: UIColor, blurRadius: CGFloat) {
        self.colorTint = color
        self.colorTintAlpha = 0.5
        self.blurRadius = blurRadius
    }
}
