//
//  ReminderDetail.swift
//  ReminderApp
//
//  Created by Dakota Sorenson on 11/21/19.
//  Copyright © 2019 Dakota Sorenson. All rights reserved.
//

import SwiftUI

struct ReminderDetail: View {
    
    @EnvironmentObject var userData: UserData
    @State private var date = Date()
    
    var reminder:Reminder

    var reminderIndex: Int {
        userData.reminders.firstIndex(where: { $0.id == reminder.id }) ?? 0
    }
    
    var body: some View {
        VStack (alignment:.leading){
        if(userData.reminders.count < 1){
            EmptyView()
        }
        else{
        Form {
            Section {
            Text("Description:").fontWeight(.semibold)
                TextView(placeholderText: "Reminder description...",text:   $userData.reminders[self.reminderIndex].title)
                    .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 100,
                    maxHeight: .infinity)
            }
            .onTapGesture(perform: {
                UIApplication.shared
                .endEditing()
            })
            
            Section {
                Picker("Category", selection: $userData.reminders[self.reminderIndex].category) {
                    ForEach( userData.categories) {
                        category in  Text(category.title).tag(category.title)

                    }
                }
                .onAppear(perform: {
                self.userData.reminders[self.reminderIndex].notificationDate = Date()
                    
                    UIApplication.shared
                                .endEditing()
                })
            }
            
            Section {
                Toggle(isOn: $userData.reminders[self.reminderIndex].remindOnDate) {
                    Text("Remind me:")
                }
        if(userData.reminders[self.reminderIndex].remindOnDate){
                    DatePicker(
                        selection: Binding($userData.reminders[self.reminderIndex].notificationDate, replacingNilWith: Date()),
                            label: {
                                Text("Alarm")
                            }
                    )
                    .onAppear(perform: {
                        UIApplication.shared
                            .endEditing()
                
                    })
                }
            }
        }
            }
        }
        .onDisappear(perform: {
            if(self.userData.reminders.count < 1)
            {
                return
            }
            
            self.trimTitle()
            self.userData.saveReminders()
            self.sendNotification()
        })
        
    }
    
    // trims any whitespace around the title
    func trimTitle() { self.userData.reminders[self.reminderIndex].title = self.userData.reminders[self.reminderIndex].title.trimmingCharacters(in: .whitespaces)
    }
    
    // saves the reminder if 'remind me' is selected
    func sendNotification() {
    if(self.userData.reminders[self.reminderIndex].remindOnDate){
            self.userData
            .notificationCenter
            .schedule(reminder: self.userData.reminders[self.reminderIndex])
        }
    }

}


struct ReminderDetail_Previews: PreviewProvider {
    static var previews: some View {
        ReminderDetail(reminder: Reminder(title: "Don't forget to buy bananas at the store bc last time you forgot the bananas and we really need bananas", notificationDate: nil, category: "To Do", remindOnDate: false)).environmentObject(UserData())
    }
}


extension Binding {
    init(_ source: Binding<Value?>, replacingNilWith nilValue: Value) {
        self.init(
            get: { source.wrappedValue ?? nilValue },
            set: { newValue in
                    source.wrappedValue = newValue
        })
    }
}
