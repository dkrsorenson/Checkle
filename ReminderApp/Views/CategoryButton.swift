//
//  CategoryView.swift
//  ReminderApp
//
//  Created by Dakota Sorenson on 11/24/19.
//  Copyright © 2019 Dakota Sorenson. All rights reserved.
//

import SwiftUI

struct CategoryButton: View {
    
    @EnvironmentObject var userData: UserData
    var category:Category
    
    var body: some View {
        VStack {
            Circle()
        .fill(self.userData.colors[category.colorIndex].color)
            .frame(width: 50, height: 50)
            Text(category.title
            .prefix(10)
            .trimmingCharacters(in: .whitespaces))
//                   .fixedSize(horizontal: false, vertical: true) .foregroundColor(.primary)
            .font(.headline)
            .multilineTextAlignment(.center)
            .lineLimit(2)
        }
        .frame(width: 100, height: 100)
    }
}

struct CategoryButton_Previews: PreviewProvider {
    static var previews: some View {
        CategoryButton(
            category: Category(
                title: "Longer Button",
                colorIndex: 3))
        .environmentObject(UserData())
    }
}
