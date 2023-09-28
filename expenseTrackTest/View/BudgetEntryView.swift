//
//  BudgetEntryView.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-28.
//

import SwiftUI

struct BudgetEntryView: View {
    @State private var selectedMonth = ""
    @State private var transportExpense = ""
    @State private var healthExpenses = ""
    
    private let firestoreService = FirestoreService()
    
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    
    
    var body: some View {
        VStack {
            Text("Select Month")
            
            Picker("Month", selection: $selectedMonth){
                ForEach(months, id: \.self){month in
                    Text(month).tag(month)
                }
            }
            .pickerStyle(MenuPickerStyle())
            
            Text("Transaport Expense: ")
            TextField("Enter amount: ", text: $transportExpense)
            
            Text("Health Expense: ")
            TextField("Enter amount: ", text: $healthExpenses)
            
            Button(action: {
                let categories = [
                    "Transport": Double(transportExpense) ?? 0.0,
                    "Health": Double(healthExpenses) ?? 0.0
                ]
                firestoreService.saveBudget(month: selectedMonth, categories: categories)
                
                //clear data
                transportExpense = ""
                healthExpenses = ""
            }) {
                Text("Save Budget")
            }
            
            NavigationLink(destination: BudgetHistoryView()){
                Text("View Budget History View")
            }
        }
    }
}

struct BudgetEntryView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetEntryView()
    }
}
