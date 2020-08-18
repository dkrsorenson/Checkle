//
//  ReminderList.swift
//  ReminderApp
//
//  Created by Dakota Sorenson on 11/18/19.
//  Copyright © 2019 Dakota Sorenson. All rights reserved.
//

import SwiftUI

struct RemindersList: View {
    
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack {
            List {
                ForEach(userData.reminders) {
                reminder in
                if (self.userData.selectedCategory == "All"
                    || self.userData.selectedCategory == reminder.category) {
                    NavigationLink (
                        destination:
                    ReminderDetail(reminder: reminder).environmentObject(self.userData)
                        )
                    {
                    ReminderRow(reminder: reminder).environmentObject(self.userData)
                    }
                    
                    }
                }
                .onMove(perform: move)
                .onDelete(perform: delete)
            }.navigationBarItems(trailing: EditButton())
        }
        .onAppear(perform: {
            self.userData.saveReminders()
        })
    }
    
    // delete reminder
    func delete(at offsets: IndexSet) {
        let index = offsets.first ?? 0
        
        if(userData.reminders[index]
        .remindOnDate){
            userData.notificationCenter
            .deleteNotification(id: userData.reminders[index].id)
        }
        
        userData.reminders.remove(atOffsets: offsets)
        userData.saveReminders()
    }
    
    // move reminder in list
    func move(from source: IndexSet, to destination: Int) {
        userData.reminders.move(fromOffsets: source, toOffset: destination)
        userData.saveReminders()
    }
}

struct ReminderList_Previews: PreviewProvider {
    static var previews: some View {
        RemindersList().environmentObject(UserData())
    }
}
