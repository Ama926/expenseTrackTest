//
//  ExpensePieChartView.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-28.
//


import SwiftUI

struct ExpensePieChartView: View {
    @ObservedObject var expenseViewModel = ExpenseViewModel()
    
    let categoryColors: [String: Color] = [
        "Transport": Color.green,
        "Food": Color.orange,
        "Utilities": Color.red,
        "Health": Color.yellow
//        "Income": Color.green,
//        "Shopping": Color.pink,
//        "Communication": Color.purple,
//        "Debts": Color.brown
        
    ]
    
    var body: some View {
        ZStack{
            Color.black
            VStack {
                Text("Transaction Analytics")
                                   .font(.title)
                                   .foregroundColor(.white)

                PieChartView(dataPoints: expenseDataPoints, categoryColors: categoryColors)
                    .frame(width: 225, height: 225) // Adjust the size as needed and center it

                HStack {
                    ForEach(Array(categoryColors.keys), id: \.self) { category in
                        HStack {
                            Circle()
                                //.fill(categoryColors[category] ?? Color.black)
                                .fill(categoryColors[category] ?? Color.white)
                                .frame(width: 20, height: 20)

                            Text(category)
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            .onAppear {
                self.expenseViewModel.fetchExpenses()
            }

        }
    }

   
    
    var expenseDataPoints: [DataPoint] {
        let categories = Set(expenseViewModel.expenses.map { $0.category })
        
        var dataPoints: [DataPoint] = []
        
        for category in categories {
            let totalAmount = expenseViewModel.expenses
                .filter { $0.category == category }
                .reduce(0) { $0 + $1.amount }
            
            dataPoints.append(DataPoint(category: category, value: totalAmount, color: categoryColors[category] ?? Color.white))
        }
        
        return dataPoints
    }
}
