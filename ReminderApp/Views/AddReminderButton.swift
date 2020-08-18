//
//  AddReminder.swift
//  ReminderApp
//
//  Created by Dakota Sorenson on 12/5/19.
//  Copyright © 2019 Dakota Sorenson. All rights reserved.
//

import SwiftUI

struct AddReminderButton: View {
    @EnvironmentObject var userData: UserData
    @State private var presentMe = false

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                NavigationLink(destination: AddReminderDetail().environmentObject(self.userData), isActive: $presentMe) { EmptyView() }

                Button(action: {
                self.userData.reminders.append(
                    Reminder(title: ""))
                    self.presentMe = true
                }) {
                    VStack {
                        Image("AddSymbol")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color.black)
                    }
                    .frame(width: 100, height: 100)
                }
            }
        }
    }
}

struct AddReminderButton_Previews: PreviewProvider {
    static var previews: some View {
        AddReminderButton()
        .environmentObject(UserData())
    }
}
