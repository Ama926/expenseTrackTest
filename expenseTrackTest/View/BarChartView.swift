//
//  BarChartView.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-25.
//

// BarChartView.swift
import SwiftUI

struct TestExp: Identifiable {
    let id = UUID()
    let category: String
    let amount: Double
}

struct BarChartView: View {
    let expenses = [
        TestExp(category: "Transport", amount: 250.0),
        TestExp(category: "Utilities", amount: 150.0),
        TestExp(category: "Transport", amount: 250.0),
        TestExp(category: "Utilities", amount: 150.0),
        TestExp(category: "Transport", amount: 250.0),
        TestExp(category: "Utilities", amount: 150.0),
        // Add more expenses here
    ]

    var body: some View {
        VStack {
            Text("Monthly Expenses")
                .font(.title)
                .padding()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(expenses) { expense in
                        BarView(expense: expense)
                    }
                }
                .padding()
            }
        }
    }
}

//import SwiftUI
//import SwiftUICharts
//
//struct TestExp: Identifiable {
//    let id = UUID()
//    let category: String
//    let amount: Double
//}
//
//struct BarChartView: View {
//    let expenses = [
//        TestExp(category: "Transport", amount: 250.0),
//        TestExp(category: "Utilities", amount: 150.0),
//        TestExp(category: "Housing", amount: 250.0),
//        TestExp(category: "Health", amount: 150.0),
//        TestExp(category: "Food", amount: 250.0),
//        TestExp(category: "Other", amount: 150.0),
//        // Add more expenses here
//    ]
//
//    var body: some View {
//        VStack {
//            Text("Monthly Expenses")
//                .font(.title)
//                .foregroundColor(Color.blue)
//                .padding(.top, 20)
//
//            BarChartView(data: ChartData(values: expenses.map { $0.amount }),
//                     title: "Categories",
//                     legend: "Amount",
//                     style: ChartStyle(backgroundColor: Color.white, accentColor: Color.blue, gradientColor: GradientColor(start: Color.blue, end: Color.purple), textColor: Color.primary, legendTextColor: Color.gray, dropShadowColor: Color.gray.opacity(0.5)))
//                .padding()
//        }
//        .background(Color.white)
//        .cornerRadius(20)
//        .shadow(radius: 5)
//        .padding()
//    }
//}
