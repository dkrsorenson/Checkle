//
//  Data.swift
//  ReminderApp
//
//  Created by Dakota Sorenson on 11/21/19.
//  Copyright © 2019 Dakota Sorenson. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI


let reminderData:[Reminder] = [
//    Reminder(
//        title: "Test reminders",
//        notificationDate: nil,
//        category: "All",
//        remindOnDate: false)
]

let categoryData:[Category] = [
    Category(
    title: "All",
    colorIndex: 7),
    Category(
        title: "To Do",
        colorIndex: 0)
]

let colorData:[MyColor] = [
    MyColor(
        name: "Red",
        color: Color.red),
    MyColor(
        name: "Orange",
        color: Color.orange),
    MyColor(
        name: "Yellow",
        color: Color.yellow),
    MyColor(
        name: "Green",
        color: Color.green),
    MyColor(
        name: "Blue",
        color: Color.blue),
    MyColor(
        name: "Purple",
        color: Color.purple),
    MyColor(
        name: "Black",
        color: Color.black),
    MyColor(
        name: "Gray",
        color: Color.gray),
    MyColor(
        name: "Pink",
        color: Color.pink)
]

let daysOfTheWeek:[Day] = [
    Day(firstLetter: "M", color: Color.purple),
    Day(firstLetter: "T", color: Color.pink),
    Day(firstLetter: "W", color: Color.red),
    Day(firstLetter: "T", color: Color.orange),
    Day(firstLetter: "F", color: Color.yellow),
    Day(firstLetter: "S", color: Color.green),
    Day(firstLetter: "S", color: Color.blue)
]

