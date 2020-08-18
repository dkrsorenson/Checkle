//
//  Reminder.swift
//  ReminderApp
//
//  Created by Dakota Sorenson on 11/18/19.
//  Copyright © 2019 Dakota Sorenson. All rights reserved.
//

import Foundation

class Reminder: Identifiable, Codable {
    
    var id = UUID()
    var title: String
    var notificationDate: Date?
    var category: String
    var remindOnDate:Bool
    
    init(title:String, notificationDate:Date?, category:String, remindOnDate:Bool){
        self.title = title
        self.notificationDate = notificationDate
        self.category = category
        self.remindOnDate = remindOnDate
    }
    
    convenience init(title:String){
        self.init(title: title, notificationDate: nil, category: "All", remindOnDate: false)
    }
}
