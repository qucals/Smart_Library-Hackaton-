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
    
    var currentUser: User!
    
    var books: [Book] = []
    var booksCollectionRef: CollectionReference!
    
    var limit = 5
    var currentLoadedCell = 0
    
    var indexSelectedCell = 0
    
    var rootViewController: LibraryNavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    
        // Set height of row
        tableView.estimatedRowHeight = 245
        tableView.rowHeight = 245
        
        booksCollectionRef = Firestore.firestore().collection(Constants.Firebase.pathToCollectionBooks)
        
        preLoadCells()
    }
    
    func preLoadCells() {
        booksCollectionRef.getDocuments { (snapshot, error) in
            if let err = error {
                debugPrint("Error fetching docs: \(err)")
            } else {
                guard let snap = snapshot else { return }
                
                for document in snap.documents {
                    if self.currentLoadedCell == self.limit {
                        return
                    }
                    
                    let data = document.data()
                    
                    let uid = document.documentID
                    guard let name = data["name"] as? String else { continue }
                    guard let author = data["author"] as? String else { continue }
                    guard let description = data["description"] as? String else { continue }
                    guard let available = data["available"] as? Bool else { continue }
                    
                    // TODO: Added loading above data from firebase
                    let image = UIImage(imageLiteralResourceName: "logo_book.png")
                    let rating: CGFloat = 0.0
                    
                    guard let book = Book(uid: uid,
                                          name: name,
                                          author: author,
                                          description: description,
                                          image: image,
                                          rating: rating,
                                          available: available) else {
                        continue
                    }
                    
                    self.books.append(book)
                    
                    self.currentLoadedCell += 1
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Storyboard.bookCellIndentifier,
                                                       for: indexPath) as? BookTableViewCell else {
            fatalError("Error with dequeued cell to BookTableViewCell")
        }
        
        let book = books[indexPath.row]
        
        cell.titleLabel.text = book.name
        cell.descriptionLabel.text = book.description
        cell.bookImage.image = book.image
        
        if indexPath.row == self.books.count - 1 {
            self.loadMoreCells()
        }
        
        return cell
    }
    
    func loadMoreCells() {
        
        var skipLoadedCells = 0
        
        limit += 5
        
        booksCollectionRef.getDocuments { (snapshot, error) in
            if let err = error {
                debugPrint("Error fetching docs: \(err)")
            } else {
                guard let snap = snapshot else { return }
                
                for document in snap.documents {
                    if skipLoadedCells != self.currentLoadedCell {
                        skipLoadedCells += 1
                        continue
                    }
                    if self.currentLoadedCell == self.limit {
                        return
                    }
                    
                    let data = document.data()
                    
                    let uid = document.documentID
                    guard let name = data["name"] as? String else { continue }
                    guard let author = data["author"] as? String else { continue }
                    guard let description = data["description"] as? String else { continue }
                    guard let available = data["available"] as? Bool else { continue }
                    
                    // TODO: Added loading above data from firebase
                    let image = UIImage(imageLiteralResourceName: "logo_book.png")
                    let rating: CGFloat = 0.0
                    
                    guard let book = Book(uid: uid,
                                          name: name,
                                          author: author,
                                          description: description,
                                          image: image,
                                          rating: rating,
                                          available: available) else {
                        continue
                    }
                    
                    self.books.append(book)
                    
                    self.currentLoadedCell += 1
                }
                
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        rootViewController.currentUser = currentUser
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexSelectedCell = indexPath.row
        
        self.performSegue(withIdentifier: Constants.Storyboard.performSegueToSelectedCell, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DetailBookViewController {
            let vc = segue.destination as? DetailBookViewController
            vc?.selectedBook = books[indexSelectedCell]
            vc?.currentUser = currentUser
            vc?.rootViewController = self
        }
    }
}
