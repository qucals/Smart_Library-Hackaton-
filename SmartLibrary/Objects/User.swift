//
//  User.swift
//  SmartLibrary
//
//  Created by Кирилл Галимзянов on 14.03.2020.
//  Copyright © 2020 Kirill Galimzyanov. All rights reserved.
//

import Foundation

class User {
    
    var title: String
    var phone: String
    var points: Int
    var taken_books: [String] = []
    var favourite_books: [String] = []
    var uid: String
    
    init?(uid: String, phone: String, title: String,
          taken_books: [String], favourite_books: [String], points: Int) {
        guard uid.count > 0 || phone.count > 0 || title.count > 0 else {
            return nil
        }
        
        self.title = title
        self.phone = phone
        self.points = points
        self.taken_books = taken_books
        self.favourite_books = favourite_books
        self.uid = uid
    }
}
