//
//  AddCategoryDetail.swift
//  ReminderApp
//
//  Created by Dakota Sorenson on 12/10/19.
//  Copyright © 2019 Dakota Sorenson. All rights reserved.
//

import SwiftUI

struct AddCategoryDetail: View {
    @EnvironmentObject var userData: UserData
    @Binding var showModal: Bool
    @State private var isDeleted = false

    var categoryIndex: Int {
        userData.categories.endIndex - 1
    }

    var body: some View {
        VStack {
            Form {
                Section {
                    Text("Title:")
                        .fontWeight(.semibold)
                    TextField("Enter category title...", text: $userData.categories[self.categoryIndex].title)
                }
                .onTapGesture(perform: {
                    UIApplication.shared
                    .endEditing()
                })
                        
                Section {
                    HStack{
                        Text("Color:")
                            .fontWeight(
                            .semibold)
                            Spacer()
                        Circle()
                        .fill(self.userData.colors[self.userData.categories[categoryIndex].colorIndex].color)
                            .frame(width: 25, height: 25)
                    }
                    HStack{
                        Spacer()
                            Picker(selection: $userData.categories[self.categoryIndex].colorIndex, label:
                                 Text("")) {
                                     ForEach(0 ..< userData.colors.count) { index in
                                         Text(self.userData.colors[index].name).tag(index)
                                     }
                                 }
                            
                                 .labelsHidden()
                             .pickerStyle(WheelPickerStyle())
                            Spacer()
                        }
                    }
                    
                    Section {
                        Button(action: {
                            print("Delete clicked")
                            print("Show Modal false")
                            self.isDeleted.toggle()

                            self.showModal.toggle()
                            UIApplication.shared
                                    .endEditing()
                        })
                        {
                            Text("Delete")
                            .foregroundColor(.red)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        }
                    }
                }
            }
        .onDisappear(perform: {
            self.trimTitle()
            self.checkForDeleteCategory()
            self.userData.saveCategories()
        })
    }
    
    // trims white space around the title
    func trimTitle() {
    self.userData.categories[self.categoryIndex].title = self.userData.categories[self.categoryIndex].title.trimmingCharacters(in: .whitespaces)
    }
    
    // check if user wanted to delete category or if the title is empty
    func checkForDeleteCategory() {
        if(self.isDeleted) {
           updateReminderCategories()
            self.userData.categories
                .remove(at: self.categoryIndex)
            self.userData.selectedCategory = "All"
        }
        else{ if(self.userData.categories[self.categoryIndex].title.isEmpty)
            {
                self.userData.categories
            .remove(at: self.categoryIndex)
                self.userData.selectedCategory = "All"

            }
        }
    }
    
    // when a category is deleted, update the reminders in the category to be set to 'all' instead
    func updateReminderCategories () {
        for reminder in userData.reminders {
            if(reminder.category == self.userData.categories[categoryIndex].title){
                reminder.category = "All"
            }
        }
        
        userData.saveReminders()
    }
}

struct AddCategoryDetail_Previews: PreviewProvider {
    @State static var showModal = true
    static var previews: some View {
        AddCategoryDetail(
            showModal: $showModal)
            .environmentObject(UserData())
    }
}
