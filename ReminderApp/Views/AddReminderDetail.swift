//
//  AddReminderDetail.swift
//  ReminderApp
//
//  Created by Dakota Sorenson on 12/10/19.
//  Copyright © 2019 Dakota Sorenson. All rights reserved.
//

import SwiftUI

struct AddReminderDetail: View {
    
    @EnvironmentObject var userData: UserData

    var reminderIndex: Int {
        userData.reminders.endIndex - 1
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
                    .frame(minWidth: 0, maxWidth:   .infinity, minHeight: 100,    maxHeight: .infinity)
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
                    }.onAppear(perform: {
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
                            self.userData.reminders[self.reminderIndex].notificationDate = Date()
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
    
    // trims whitespace around the title
    func trimTitle() {
    self.userData.reminders[self.reminderIndex].title = self.userData.reminders[self.reminderIndex].title.trimmingCharacters(in: .whitespaces)
    }
    
    // sends notification if 'remind me' is selected
    func sendNotification() {
    if(self.userData.reminders[self.reminderIndex].remindOnDate){
        
            self.userData
            .notificationCenter
            .schedule(reminder: self.userData.reminders[self.reminderIndex])

        }
    }
}

struct AddReminderDetail_Previews: PreviewProvider {
    static var previews: some View {
        AddReminderDetail()
            .environmentObject(UserData())
    }
}
