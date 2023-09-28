//
//  DataPoint.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-28.
//


import Foundation
import SwiftUI

struct DataPoint: Identifiable {
    var id = UUID() // You can use a unique identifier for each data point
    var category: String
    var value: Double
    var color: Color
}

