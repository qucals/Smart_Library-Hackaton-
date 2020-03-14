//
//  DetailBookViewController.swift
//  SmartLibrary
//
//  Created by Кирилл Галимзянов on 14.03.2020.
//  Copyright © 2020 Kirill Galimzyanov. All rights reserved.
//

import UIKit
import FirebaseDatabase
import LGButton

class DetailBookViewController: UIViewController {
    
    @IBOutlet weak var takeButton: LGButton!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var desciprtionLabel: UILabel!
    
    var selectedBook: Book!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = selectedBook.name
        authorLabel.text = selectedBook.author
        desciprtionLabel.text = selectedBook.description
        takeButton.isHidden = !selectedBook.available
        
        // let image = resizeImage(image: selectedBook.image, targetSize: CGSize(width: bookImage.bounds.size.width, height: bookImage.bounds.size.height))
        
        bookImage.image = selectedBook.image
        setBlurEffect()
        // bookImage.image = blurImage(usingImage: selectedBook.image, blurAmount: 90.0)
        
        bookImage.contentMode = .scaleAspectFill
    }
    
    func setBlurEffect() {
        if !UIAccessibility.isReduceTransparencyEnabled {
            bookImage.backgroundColor = .clear

            let blurEffect = UIBlurEffect(style: .light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            
            //always fill the view
            blurEffectView.frame = bookImage.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

            bookImage.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
        } else {
            bookImage.backgroundColor = .black
        }
    }
    
    @IBAction func favouriteTapped(_ sender: Any) {
    }
    
    @IBAction func takeTapped(_ sender: Any) {
    }
}
