//
//  UserData.swift
//  ReminderApp
//
//  Created by Dakota Sorenson on 11/25/19.
//  Copyright © 2019 Dakota Sorenson. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import UserNotifications

final class UserData: ObservableObject {
    let didChange = PassthroughSubject<UserData, Never>()
    
    // keys for user defaults
    let categoriesKey = "categories"
    let remindersKey = "reminders"
    
    let notificationCenter = NotificationManager()

    // Array of reminders
    @Published var reminders:[Reminder] = reminderData {
        didSet {
            didChange.send(self)
        }
    }

    // Array of categories
    @Published var categories:[Category] = categoryData {
        didSet {
            didChange.send(self)
        }
    }
    
    // The currently selected / tapped category to filter the reminders on
    @Published var selectedCategory:String = "All"

    // The array of colors for the categories
    var colors = colorData
    
    // Lod reminders and categories on init
    init() {
        loadReminders()
        loadCategories()
    }
    
    // Save the reminders in user defaults
    func saveReminders() {
        do {
            try UserDefaults.standard.set(JSONEncoder().encode(reminders), forKey: remindersKey)
            print("Now saving reminders!")
        }
        catch {
            print("ERROR: Problem saving reminders!")
        }
    }

    // Load the reminders from user defaults
    func loadReminders() {
        guard let encoded = UserDefaults.standard.object(forKey: remindersKey) as? Data else {
            print("WARNING: Could not find a value for the 'reminders' key!")
            return
        }
        
        do {
            let decodedReminders = try JSONDecoder().decode([Reminder].self, from: encoded)
            print("Now loading reminders!")
            for reminder in decodedReminders {
                print(reminder.title)
            }
            reminders = decodedReminders
        }
        catch {
            print("ERROR: Problem decoding reminders!")
        }
    }
    
    // Save the categories in user defaults
    func saveCategories() {
        do {
            try UserDefaults.standard.set(JSONEncoder().encode(categories), forKey: categoriesKey)
            print("Now saving categories!")
        }
        catch {
            print("ERROR: Problem saving categories!")
        }
    }

    // Load in the categories from user defaults
    func loadCategories() {
        guard let encoded = UserDefaults.standard.object(forKey: categoriesKey) as? Data else {
            print("WARNING: Could not find a value for the 'categories' key!")
            return
        }
        
        do {
            let decodedCategories = try JSONDecoder().decode([Category].self, from: encoded)
            print("Now loading categories!")
            for category in decodedCategories {
                print(category.title)
            }
            categories = decodedCategories
        }
        catch {
            print("ERROR: Problem decoding categories!")
        }
    }

}

