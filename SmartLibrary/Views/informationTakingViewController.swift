//
//  informationTakingViewController.swift
//  SmartLibrary
//
//  Created by Кирилл Галимзянов on 15.03.2020.
//  Copyright © 2020 Kirill Galimzyanov. All rights reserved.
//

import Foundation
import FirebaseFirestore

class InformationTaking: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var currentUser: User!
    var selectedBook: Book!
    var rootViewController: DetailBookViewController!
    
    @IBOutlet weak var selectedLibrary: UIPickerView!
    @IBOutlet weak var selectedDate: UIDatePicker!
    
    var pickerData: [String] = []
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        selectedLibrary.delegate = self
        selectedLibrary.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let query = self.db.collection(Constants.Firebase.pathToCollectionBooks)
        query.getDocuments { (snapshot, err) in
            guard let snap = snapshot else { return }
            
            for document in snap.documents {
                let data = document.data()
                
                guard let name = data["id_library"] as? String else { continue }
                
                self.pickerData.append(name)
            }
        
            self.selectedLibrary.reloadInputViews()
            self.viewDidLoad()
        }
    }
    
    @IBAction func tappedDone(_ sender: Any) {
        let query = db.collection(Constants.Firebase.pathToUsers).document(currentUser.uid)
        query.updateData([
            "taken_books": FieldValue.arrayUnion(["\(selectedBook!.uid)"])
        ])
        
        let _query = db.collection(Constants.Firebase.pathToCollectionBooks).document(selectedBook.uid)
        _query.updateData([
            "available": false
        ])
        
        let __query = db.collection(Constants.Firebase.pathToRecords).addDocument(data: [
            "d_issue": selectedDate.date,
            "id_book": selectedBook.uid,
            "id_user": currentUser.uid
        ])
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        rootViewController.currentUser = currentUser
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
}
