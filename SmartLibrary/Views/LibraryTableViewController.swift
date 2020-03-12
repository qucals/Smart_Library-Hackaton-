//
//  LibraryTableViewController.swift
//  SmartLibrary
//
//  Created by Кирилл Галимзянов on 12.03.2020.
//  Copyright © 2020 Kirill Galimzyanov. All rights reserved.
//

import UIKit
import FirebaseFirestore

class LibraryTableViewController: UITableViewController {
    
    var books: [Book] = []
    var booksCollectionRef: CollectionReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    
        tableView.estimatedRowHeight = 245
        tableView.rowHeight = 245
        
        booksCollectionRef = Firestore.firestore().collection(Constants.Firebase.pathToCollectionBooks)
    }

    override func viewWillAppear(_ animated: Bool) {
        booksCollectionRef.getDocuments { (snapshot, error) in
            if let err = error {
                debugPrint("Error fetching docs: \(err)")
            } else {
                guard let snap = snapshot else { return }
                
                for document in snap.documents {
                    let data = document.data()
                    
                    let name = data["name"] as? String ?? "Unknown Book"
                    let description = data["description"] as? String ?? "Unknown description"
                    let available = data["canTake"] as? Bool ?? true
                    
                    // TODO: Added loading above data from firebase
                    let image = UIImage(contentsOfFile: "logo_book.jpg")
                    let rating: CGFloat = 0.0
                    
                    guard let book = Book(name: name, description: description, image: image, rating: rating, available: available) else {
                        return
                    }
                    
                    self.books.append(book)
                }
                
                self.tableView.reloadData()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Storyboard.cellIdentifier, for: indexPath) as? BookTableViewCell else {
            fatalError("Error with dequeued cell to BookTableViewCell")
        }
        
        let book = books[indexPath.row]
        
        cell.titleLabel.text = book.name
        cell.descriptionLabel.text = book.description
        cell.bookImage.image = book.image
        
        return cell
    }
}
