//
//  Category.swift
//  ReminderApp
//
//  Created by Dakota Sorenson on 11/21/19.
//  Copyright © 2019 Dakota Sorenson. All rights reserved.
//

import Foundation
import SwiftUI

class Category: Identifiable, Codable {
    var id = UUID()
    var title:String
    var colorIndex:Int
    
    init(title:String, colorIndex:Int){
        self.title = title
        self.colorIndex = colorIndex
    }
}


struct MyColor {
    var name:String
    var color:Color
}

