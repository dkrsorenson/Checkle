//
//  ContentView.swift
//  ReminderApp
//
//  Created by Dakota Sorenson on 11/18/19.
//  Copyright © 2019 Dakota Sorenson. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    CategoriesList()
                    .environmentObject(self.userData)
                    RemindersList()
                    .environmentObject(self.userData)
                }
                AddReminderButton()
                    .environmentObject(
                        self.userData)
            }
            .navigationBarTitle("Reminders")
        }
        .navigationViewStyle(
            StackNavigationViewStyle()
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserData())
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
