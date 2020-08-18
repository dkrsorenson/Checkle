//
//  CategoriesList.swift
//  ReminderApp
//
//  Created by Dakota Sorenson on 11/21/19.
//  Copyright © 2019 Dakota Sorenson. All rights reserved.
//

import SwiftUI

public enum ActiveSheet {
   case existing, add
}

struct CategoriesList: View {
    
    @EnvironmentObject var userData: UserData
    @State private var showModal: Bool = false
    @State private var pressedCategory: Category = Category(title: "All", colorIndex: 7)
    @State private var activeSheet: ActiveSheet = .existing

    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                 ForEach(userData.categories){
                    category in
                    CategoryButton(
                    category: category)
                    .environmentObject(
                        self.userData)
                    .onTapGesture {
                    self.userData.selectedCategory = category.title
                    }
                    .onLongPressGesture {
                        self.pressedCategory = category
                    if(self.pressedCategory.title != "All")
                        {
                            self.activeSheet = .existing
                            self.showModal = true
                        }
                           
                    }
                }
                    
            VStack{
                Button(action: {
                self.userData.categories.append(
                        Category(
                            title: "",
                            colorIndex: 0))
                    self.activeSheet = .add
                    self.showModal = true
                }) {
                    VStack {
                        Image("AddSymbol")
                        .resizable()
                        .frame(width: 50, height: 50)
                        Text("Add")
                        .foregroundColor(.primary) .font(.headline)
                            
                    }
                    .frame(width: 100, height: 100)
                }
                }
                .frame(width: 100, height: 100)
                }
            }
        }
        .sheet(isPresented: self.$showModal) {
            if(self.activeSheet == .existing){

                CategoryDetail(
                    showModal: self.$showModal,
                    category: self.pressedCategory)
                .environmentObject(
                        self.userData)
                .onDisappear(perform: {
                    self.userData
                    .saveCategories()
                })
            }
            else if(self.activeSheet == .add){
                AddCategoryDetail(showModal: self.$showModal)
                .environmentObject(
                    self.userData)
                .onDisappear(perform: {
                    self.userData
                    .saveCategories()
                })
            }

        }
    }
}

struct CategoriesList_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesList()
        .environmentObject(UserData())
    }
}



      
