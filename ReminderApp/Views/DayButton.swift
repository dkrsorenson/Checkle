//
//  DayButton.swift
//  ReminderApp
//
//  Created by Dakota Sorenson on 12/4/19.
//  Copyright © 2019 Dakota Sorenson. All rights reserved.
//

import SwiftUI

struct Day: Identifiable {
    var id = UUID()
    var firstLetter:String = ""
    var color:Color = Color.gray
}

struct DayButton: View {
    
    @State private var isEnabled:Bool = false
    var day: Day
    
    var body: some View {
        VStack { Text(day.firstLetter).foregroundColor(Color.white)
            .padding()
            .background(self.isEnabled ? day.color :    Color.gray)
            .cornerRadius(5)
            .mask(Circle())
            }
        .onTapGesture {
            self.isEnabled.toggle()
        }
    }
}

struct DayButtonStyle: ButtonStyle {
    var color:Color
  
  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .padding()
        .background(configuration.isPressed ? color : Color.gray)
       .cornerRadius(5)
       .mask(Circle())
  }
}


struct DayButton_Previews: PreviewProvider {
    static var previews: some View {
        DayButton(day: Day(firstLetter: "M", color: Color.red))
    }
}
