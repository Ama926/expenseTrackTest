//
//  Home.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-24.
//

//
import SwiftUI
//
//struct HomeView: View {
//    //@AppStorage("uid") var userID: String = ""
//    @ObservedObject var viewModel = ExpenseViewModel()
//
//    var body: some View {
//        VStack {
//            CardView2(title: "Total Income", amount: viewModel.totalIncome)
//            CardView2(title: "Total Expenses", amount: viewModel.totalExpenses)
//            CardView2(title: "Difference", amount: viewModel.totalIncome - viewModel.totalExpenses)
//        }
//    }
//}
//
//struct CardView2: View {
//    var title: String
//    var amount: Double
//
//    var body: some View {
//        VStack {
//            Text(title)
//                .font(.headline)
//            Text(String(format: "$%.2f", amount))
//                .font(.largeTitle)
//        }
//        .padding()
//        .background(Color.blue)
//        .foregroundColor(.white)
//        .cornerRadius(10)
//        .padding()
//    }
//}
//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}


struct HomeView: View {
    //@AppStorage("uid") var userID: String = ""
    @ObservedObject var viewModel = ExpenseViewModel()
    
    var body: some View {
        
        ZStack{
            Color.black.ignoresSafeArea()
            VStack {
                
                Text("Welcome to Your Financial Summary")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(.top, 10)
                                .multilineTextAlignment(.center)
                VStack{
                    CardView2(title: "Total Income", amount: viewModel.totalIncome, cardColor: .green.opacity(0.5))
                    CardView2(title: "Total Expenses", amount: viewModel.totalExpenses, cardColor: .red.opacity(0.5))
                    CardView2(title: "Difference", amount: viewModel.totalIncome - viewModel.totalExpenses, cardColor: viewModel.totalIncome >= viewModel.totalExpenses ? Color.green.opacity(0.8) : Color.yellow.opacity(0.8))
                }
                
            }
        }
        
    }
}

struct CardView2: View {
    var title: String
    var amount: Double
    var cardColor: Color
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            Text(String(format: "%.2f LKR", amount))
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .frame(width: 250, height: 150)
        .background(cardColor)
        .cornerRadius(15)
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
