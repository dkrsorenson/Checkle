//
//  CategoryDetail.swift
//  ReminderApp
//
//  Created by Dakota Sorenson on 11/24/19.
//  Copyright © 2019 Dakota Sorenson. All rights reserved.
//

import SwiftUI
import UIKit

struct CategoryDetail: View {
    
    @EnvironmentObject var userData: UserData
    @State private var categoryTitle:String = ""
    @State private var isDeleted = false
    @Binding var showModal: Bool

    var category:Category

    var categoryIndex: Int {
        userData.categories.firstIndex(where: { $0.id == category.id }) ?? 0
    }

    var body: some View {
        VStack {
            Form {
                Section {
                    Text("Title:")
                    .fontWeight(.semibold)
                    TextField("Enter category title...", text: $userData.categories[self.categoryIndex].title)
                }
                    
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
    
    func trimTitle() {
    self.userData.categories[self.categoryIndex].title = self.userData.categories[self.categoryIndex].title.trimmingCharacters(in: .whitespaces)
    }
    
    // checks if user wants to delete category and if title is empty
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
            if(reminder.category == category.title){
                reminder.category = "All"
            }
        }
        
        userData.saveReminders()
    }
}

struct CategoryDetail_Previews: PreviewProvider {
    @State static var showModal = true

    static var previews: some View {
        CategoryDetail(
            showModal: $showModal,
            category: Category(
                title: "To Do",
                colorIndex: 0)
        ).environmentObject(UserData())
    }
}
