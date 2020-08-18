//
//  ReminderRow.swift
//  ReminderApp
//
//  Created by Dakota Sorenson on 11/18/19.
//  Copyright © 2019 Dakota Sorenson. All rights reserved.
//

import SwiftUI

struct ReminderRow: View {
    @EnvironmentObject var userData: UserData
    var reminder:Reminder
    
    var reminderIndex: Int {
        userData.reminders.firstIndex(where: { $0.id == reminder.id }) ?? 0
    }
    
    var colorIndex: Int {
        userData.categories.first(where: {
            $0.title == reminder.category
            })?.colorIndex ?? 7
    }
    
    var body: some View {
        HStack {
            if(userData.reminders.count < 1){
                EmptyView()
            }
            else{
            Circle()
            .stroke(lineWidth: 2)
                .fill(self.userData.colors[colorIndex].color)
            .frame(width: 20.0, height: 20.0)
           
            VStack (alignment: .leading){
                Spacer()
                Spacer()
           
                if(!reminder.title.isEmpty){ Text(reminder.title.trimmingCharacters(in: .whitespaces))
                .lineLimit(2)
                }
                else {
                    Text("New reminder")
                    .lineLimit(2)
                }

            if(self.userData.reminders[reminderIndex].remindOnDate) {
                if(self.userData.reminders[self.reminderIndex].notificationDate != nil)
                    {
                        Text(dateToString(date: self.userData.reminders[reminderIndex].notificationDate!))
                    .foregroundColor(Color.gray)
                    }
                    else {
                    Text(dateToString(date: Date()))
                    .foregroundColor(Color.gray)
                    }
                }
                
                Spacer()
            }
            .padding(.leading)
            
            Spacer()
        }
        }
    }
        
    func dateToString(date:Date)->String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy, E, hh:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.string(from: date)
    }
}
    

struct ReminderRow_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ReminderRow(
                reminder: Reminder(
                    title: "Get groceries",
                    notificationDate: Date(),
                    category: "To Do",
                    remindOnDate: true))
            ReminderRow(
                reminder: Reminder(
                    title: "Grab food from family before class I am making this longer to test",
                    notificationDate: nil,
                    category: "Shopping",
                    remindOnDate: false))
        }
        .previewLayout(.fixed(width: 300, height: 70))
        .environmentObject(UserData())
    }
}

