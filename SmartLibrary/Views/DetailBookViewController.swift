//
//  DetailBookViewController.swift
//  SmartLibrary
//
//  Created by Кирилл Галимзянов on 14.03.2020.
//  Copyright © 2020 Kirill Galimzyanov. All rights reserved.
//

import UIKit
import FirebaseFirestore
import LGButton

class DetailBookViewController: UIViewController {
    
    @IBOutlet weak var takeButton: LGButton!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var desciprtionLabel: UILabel!
    
    var selectedBook: Book!
    var currentUser: User!
    
    var rootViewController: LibraryTableViewController!
    
    let db =  Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = selectedBook.name
        authorLabel.text = selectedBook.author
        desciprtionLabel.text = selectedBook.description
        takeButton.isHidden = !selectedBook.available
        
        bookImage.image = selectedBook.image
        setBlurEffect()
        
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
        
        let alert: UIAlertController!
        
        if let _ = currentUser.favourite_books.first(where: { $0 == self.selectedBook.uid }) {
            
            alert = UIAlertController(title: "Ошибка",
                                          message: "Книга уже добавлена в список желаемых книг!",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: nil))
            
        } else {
            currentUser.favourite_books.append(selectedBook.uid)
            let query = db.collection(Constants.Firebase.pathToUsers).document(currentUser.uid)
            
            query.updateData([
                "favourite_books" : FieldValue.arrayUnion(["\(selectedBook.uid)"])
            ])
            
            alert = UIAlertController(title: "Информация",
                                          message: "Книга успешно добавлена!",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Хорошо",
                                          style: .default,
                                          handler: { action in self.dismiss(animated: true, completion: nil)
            }))
        }
        
        self.present(alert, animated: true)
    }
    
    @IBAction func takeTapped(_ sender: Any) {
        
        performSegue(withIdentifier: Constants.Storyboard.performSegueToInformationTaking, sender: self)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        rootViewController.currentUser = currentUser
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? InformationTaking {
            vc.currentUser = currentUser
            vc.rootViewController = self
            vc.selectedBook = selectedBook
        }
    }
}
