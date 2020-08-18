//
//  Notifications.swift
//  ReminderApp
//
//  Created by Dakota Sorenson on 12/11/19.
//  Copyright © 2019 Dakota Sorenson. All rights reserved.
//

import Foundation
import UserNotifications


class NotificationManager {
    // notification center
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    // Request to send notifications to the user
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        
        self.userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
//            if let error = error {
//                print("ERROR: ", error)
//            }
        }
    }

    // send a notification
    func sendNotification(reminder:Reminder) {
        let content = UNMutableNotificationContent()
        content.title = "Checkle"
        content.body = reminder.title
        
        let date = reminder.notificationDate ?? Date()

        let dateComponents = Calendar.current.dateComponents([.year, .month, .hour, .day, .minute], from: date)

        let trigger = UNCalendarNotificationTrigger(
        dateMatching: dateComponents, repeats: false)

        let request = UNNotificationRequest(
            identifier: reminder.id.uuidString,
            content: content,
            trigger: trigger)
        
        print(reminder.id.uuidString)
        
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
            
            print("Added notification!")
        }
        
    }

    // handle deleting a notification
    func deleteNotification(id:UUID) {
    userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [id.uuidString])
        print("Removed notification!")
    }
    
    // schedule a reminder
    func schedule(reminder:Reminder) -> Void {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                self.requestNotificationAuthorization()
                //self.sendNotification(reminder: reminder)
            case .authorized, .provisional:
                self.sendNotification(reminder: reminder)
            default:
                break
            }
        }
    }
}
