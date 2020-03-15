//
//  EventsTableViewController.swift
//  SmartLibrary
//
//  Created by Кирилл Галимзянов on 15.03.2020.
//  Copyright © 2020 Kirill Galimzyanov. All rights reserved.
//

import UIKit
import FirebaseFirestore

class EventsTableViewController: UITableViewController {

    var currentUser: User!
    var rootViewController: EventsNavigationController!
    
    var events: [Event] = []
    var eventsCollectionRef: CollectionReference!
    
    var limit = 10
    var currentLoadedCell = 0
    
    var indexSelectedCell = 0
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    
        // Set height of row
        tableView.estimatedRowHeight = 280
        tableView.rowHeight = 280
        
        eventsCollectionRef = db.collection(Constants.Firebase.pathToEvents)
        
        preLoadCells()
    }
    
    func preLoadCells() {
        eventsCollectionRef.getDocuments { (snapshot, error) in
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
                    guard let title = data["name"] as? String else { continue }
                    guard let id_library = data["id_library"] as? String else { continue }
                    guard let date = data["date"] as? Timestamp else { continue }
                    guard let description = data["description"] as? String else { continue }
                    guard let communicate = data["communication"] as? String else { continue }
                    
                    guard let event = Event(uid: uid, title: title, description: description, date: date, communicate: communicate, id_library: id_library) else { continue }
                                    
                    self.events.append(event)
                    
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
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Storyboard.eventCellIndentifier,
                                                       for: indexPath) as? EventTableViewCell else {
            fatalError("Error with dequeued cell to BookTableViewCell")
        }
        
        let event = events[indexPath.row]
        
        cell.titleLabel.text = event.title
        cell.descriptionLabel.text = event.description
        cell.libraryLabel.text = event.id_library
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedTimeStr = formatter.string(from: event.date.dateValue())
        cell.dateLabel.text = formattedTimeStr
        
        cell.communicateLabel.text = event.communicate
        
        if indexPath.row == self.events.count - 1 {
            self.loadMoreCells()
        }
        
        return cell
    }
    
    func loadMoreCells() {
        
        var skipLoadedCells = 0
        
        limit += 5
        
        eventsCollectionRef.getDocuments { (snapshot, error) in
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
                    guard let title = data["name"] as? String else { continue }
                    guard let date = data["date"] as? Timestamp else { continue }
                    guard let description = data["description"] as? String else { continue }
                    guard let communicate = data["communication"] as? String else { continue }
                    guard let id_library = data["id_library"] as? String else { continue }
                    
                    guard let event = Event(uid: uid, title: title, description: description, date: date, communicate: communicate, id_library: id_library) else { continue }
                    
                    self.events.append(event)
                    
                    self.currentLoadedCell += 1
                }
                
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexSelectedCell = indexPath.row
        
        let alert = UIAlertController(title: "Уведомления", message: "Уведомить вас о наступлении мероприятия?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { (action) in
            let query = self.db.collection(Constants.Firebase.pathToUsers).document(self.currentUser.uid)
            query.updateData([
                "Events": FieldValue.arrayUnion(["\(self.events[self.indexSelectedCell].uid)"])
            ])
        }))
    
        alert.addAction(UIAlertAction(title: "Нет", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        rootViewController.currentUser = currentUser
    }
}
