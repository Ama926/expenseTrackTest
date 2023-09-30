//
//  ExpensePieChartView.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-28.
//

//import SwiftUI
//
//struct ExpensePieChartView: View {
//    @ObservedObject var expenseViewModel = ExpenseViewModel()
//
//    var body: some View {
//        PieChartView(dataPoints: expenseDataPoints)
//            .onAppear {
//                self.expenseViewModel.fetchExpenses()
//            }
//    }
//
//    var expenseDataPoints: [DataPoint] {
//        let categories = Set(expenseViewModel.expenses.map { $0.category })
//
//        var dataPoints: [DataPoint] = []
//
//        for category in categories {
//            let totalAmount = expenseViewModel.expenses
//                .filter { $0.category == category }
//                .reduce(0) { $0 + $1.amount }
//
//            dataPoints.append(DataPoint(category: category, value: totalAmount, color: Color.random()))
//        }
//
//        return dataPoints
//    }
//
//}

import SwiftUI

struct ExpensePieChartView: View {
    @ObservedObject var expenseViewModel = ExpenseViewModel()
    
    let categoryColors: [String: Color] = [
        "Transport": Color.blue,
        "Food": Color.orange,
        "Utilities": Color.red,
        "Health": Color.yellow,
        "Income": Color.green
        // Add more categories and colors as needed
    ]
    
    var body: some View {
        VStack {
            PieChartView(dataPoints: expenseDataPoints, categoryColors: categoryColors)
                .frame(width: 200, height: 200) // Adjust the size as needed and center it
            
            HStack {
                ForEach(Array(categoryColors.keys), id: \.self) { category in
                    HStack {
//                        Text("Expenses Analytics")
//                            .font(.title)
                        Circle()
                            .fill(categoryColors[category] ?? Color.black)
                            .frame(width: 10, height: 10)
                        
                        Text(category)
                            .font(.caption)
                    }
                }
            }
        }
        .onAppear {
            self.expenseViewModel.fetchExpenses()
        }
    }
    
    var expenseDataPoints: [DataPoint] {
        let categories = Set(expenseViewModel.expenses.map { $0.category })
        
        var dataPoints: [DataPoint] = []
        
        for category in categories {
            let totalAmount = expenseViewModel.expenses
                .filter { $0.category == category }
                .reduce(0) { $0 + $1.amount }
            
            dataPoints.append(DataPoint(category: category, value: totalAmount, color: categoryColors[category] ?? Color.blue))
        }
        
        return dataPoints
    }
}
