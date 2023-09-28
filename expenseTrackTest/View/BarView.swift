//
//  BarView.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-25.
//
//import SwiftUICharts
//import SwiftUI
//
//struct ExpenseBarChartView: View {
//    @ObservedObject var expenseViewModel = ExpenseViewModel()
//
//    var body: some View {
//        BarChartView(dataPoints: expenseDataPoints)
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
//}
//
