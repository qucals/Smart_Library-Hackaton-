//
//  Event.swift
//  SmartLibrary
//
//  Created by Кирилл Галимзянов on 15.03.2020.
//  Copyright © 2020 Kirill Galimzyanov. All rights reserved.
//

import Foundation
import FirebaseFirestore

class Event {
    
    var title: String
    var description: String
    var uid: String
    var date: Timestamp
    var communicate: String
    var id_library: String
    
    init?(uid: String, title: String, description: String, date: Timestamp, communicate: String, id_library: String) {
        guard title.count > 0 || description.count > 0 || uid.count > 0 else {
            return nil
        }
        
        self.uid = uid
        self.title = title
        self.description = description
        self.date = date
        self.communicate = communicate
        self.id_library = id_library
    }
}
