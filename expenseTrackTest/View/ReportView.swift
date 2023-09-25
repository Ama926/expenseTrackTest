//
//  ReportView.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-24.
//

import SwiftUI
import SwiftUICharts // Import the SwiftUICharts library

struct ReportView: View {
    
    @State private var expenses: [Expense] = [] // Your expense data

    var body: some View {
        
        ZStack {
            Color.blue
            Image(systemName: "person.fill")
                .foregroundColor(.white)
                .font(.system(size: 100.0))
        }
        
        VStack {
            if !expenses.isEmpty {
//                BarChartView(data: ChartData(points: expenses.map { Double($0.amount) }), title: "Monthly Expenses", legend: "Categories")
                //BarChartView()
            } else {
                Text("Loading...")
                    .padding()
            }
        }
        .onAppear {
            FirestoreManager.shared.fetchMonthlyExpenses { fetchedExpenses in
                self.expenses = fetchedExpenses
            }
        }
    }
}

