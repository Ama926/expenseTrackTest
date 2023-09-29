//
//  BudgetHistoryView.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-28.
//

import SwiftUI

struct BudgetHistoryView: View {
    @State private var budgets: [Budget] = []
    private let firestoreService = FirestoreService()
    
    var body: some View {
        ScrollView{
            VStack{
                ForEach(budgets, id: \.month) { budget in
                    CardView(budget: budget)
                }

            }
            .padding()

        }
        .onAppear{
            //fetch
            firestoreService.getBudgetHistory { budgets in
                self.budgets = budgets
            }
        }
    }
}

//struct CardView: View {
//    let budget: Budget
//
//    var body: some View {
//        VStack {
//            Text(budget.month)
//                .font(.title)
//                .fontWeight(.bold)
//
//            ForEach(budget.categories.sorted(by: <), id: \.key) { category, amount in
//                            HStack {
//                                Text(category)
//                                Spacer()
//                                Text("$\(amount, specifier: "%.2f")")
//                            }
//                        }
//                .padding(.vertical, 10)
//
//        }
//                            .background(Color.white)
//                            .cornerRadius(10)
//                            //.shadow(radius: 1)
//                            .padding(.vertical, 5)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 10)
//                                    .stroke(lineWidth: 2)
//                                    .foregroundColor(.black)
//                            )
//                            .padding()
//    }
//}
//
//

struct CardView: View {
    let budget: Budget
    
    var body: some View {
        VStack {
            Text(budget.month)
                .font(.title)
                .fontWeight(.bold)
            
            ForEach(budget.categories.sorted(by: <), id: \.key) { category, amount in
                HStack {
                    Text(category)
                        .font(.headline) // Adjust font size if needed
                    Spacer()
                    Text("\(amount, specifier: "%.2f LKR")")
                        .font(.title3) // Adjust font size if needed
                }
                .padding(.vertical, 5) // Adjust vertical spacing
            }
        }
        .background(Color.white)
        .cornerRadius(10)
        .padding(.vertical, 5)
        .padding(.horizontal, 3)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 2)
                .foregroundColor(.black)
        )
        .padding()
    }
}
