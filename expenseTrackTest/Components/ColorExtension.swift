//
//  ColorExtension.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-28.
//



import SwiftUI

extension Color {
    static func random() -> Color {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        return Color(red: red, green: green, blue: blue)
    }
}

