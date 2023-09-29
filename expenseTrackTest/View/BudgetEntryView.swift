//
//  BudgetEntryView.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-28.
//

import SwiftUI

struct ExpenseTextField: View {
    @Binding var expense: String
    let placeholder: String

    var body: some View {
        HStack {
            TextField(placeholder, text: $expense)
            Spacer()
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 2)
                .foregroundColor(.black)
        )
        .padding()
    }
}

struct BudgetEntryView: View {
    @State private var selectedMonth = ""
    @State private var transportExpense = ""
    @State private var healthExpenses = ""
    @State private var foodExpenses = ""
    @State private var utilitiesExpenses = ""
    @State private var educationExpenses = ""
    @State private var incomeRecords = ""
    
    private let firestoreService = FirestoreService()
    
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var expenseTypes: [(String, Binding<String>)] {
        [
            ("Transport", $transportExpense),
            ("Health", $healthExpenses),
            ("Food", $foodExpenses),
            ("Utilities", $utilitiesExpenses),
            ("Education", $educationExpenses)
        ]
    }
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer(minLength: 20)
                HStack {
                    Text("Enter New Budget")
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                .padding()
                .padding(.top)
                
                Spacer()
                
                Text("Select Month")
                
                Picker("Month", selection: $selectedMonth) {
                    ForEach(months, id: \.self) { month in
                        Text(month).tag(month)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                Spacer()
                
                ForEach(expenseTypes, id: \.0) { type, binding in
                    ExpenseTextField(expense: binding, placeholder: type)
                }
                
                Button(action: {
                    var categories = [String: Double]()
                    for (type, binding) in expenseTypes {
                        categories[type] = Double(binding.wrappedValue) ?? 0.0
                    }
                    firestoreService.saveBudget(month: selectedMonth, categories: categories)
                    
                    // Clear data
                    for (_, binding) in expenseTypes {
                        binding.wrappedValue = ""
                    }
                }) {
                    Text("Save")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black)
                        )
                        .padding(.horizontal)
                }
                
                Spacer(minLength: 20)
                
                NavigationLink(destination: BudgetHistoryView()) {
                    Text("View Budget History")
                }
            }
            .padding()
            Spacer()
        }
    }
}

struct BudgetEntryView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetEntryView()
    }
}
