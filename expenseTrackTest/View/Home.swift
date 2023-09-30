//
//  Home.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-24.
//

//
import SwiftUI

struct HomeView: View {
    //@AppStorage("uid") var userID: String = ""
    @ObservedObject var viewModel = ExpenseViewModel()
    
    var body: some View {
        
        ZStack{
            Color.white
            VStack {
                
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .foregroundStyle(.linearGradient(colors: [.green, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 400, height: 250)
                    .rotationEffect(.degrees(180))
                    .offset(y: -100)
                    .overlay(
                            Text("Welcome Back, Ama")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                        )
           
                //VStack{
                    
                CardView2(title: "Total Income", amount: viewModel.totalIncome, cardColor: .green.opacity(0.8), iconSystemName: "arrow.up.circle.fill")
                
                CardView2(title: "Total Expenses", amount: viewModel.totalExpenses, cardColor: .red.opacity(0.9), iconSystemName: "arrow.down.circle.fill")
                
                CardView2(title: "Difference", amount: viewModel.totalIncome - viewModel.totalExpenses, cardColor: viewModel.totalIncome >= viewModel.totalExpenses ? Color.yellow.opacity(0.8) : Color.yellow.opacity(0.8), iconSystemName: "arrow.right.circle.fill")

                //}
                
            }
        }
        .ignoresSafeArea()
    }
        
}

struct CardView2: View {
    var title: String
    var amount: Double
    var cardColor: Color
    var iconSystemName: String // The SF Symbol name for the icon
    
    init(title: String, amount: Double, cardColor: Color, iconSystemName: String) {
        self.title = title
        self.amount = amount
        self.cardColor = cardColor
        self.iconSystemName = iconSystemName
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: iconSystemName) // Add the SF Symbol for the icon
                    .font(.title)
                    .foregroundColor(.white)
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            Text(String(format: "%.2f LKR", amount))
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .frame(width: 350, height: 100)
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
