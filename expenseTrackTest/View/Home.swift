//
//  Home.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-24.
//


import SwiftUI

struct HomeView: View {
    //@AppStorage("uid") var userID: String = ""
    @ObservedObject var viewModel = ExpenseViewModel()
    
    var body: some View {
        VStack {
            CardView2(title: "Total Income", amount: viewModel.totalIncome)
            CardView2(title: "Total Expenses", amount: viewModel.totalExpenses)
            CardView2(title: "Difference", amount: viewModel.totalIncome - viewModel.totalExpenses)
        }
    }
}

struct CardView2: View {
    var title: String
    var amount: Double
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            Text(String(format: "$%.2f", amount))
                .font(.largeTitle)
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(10)
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
