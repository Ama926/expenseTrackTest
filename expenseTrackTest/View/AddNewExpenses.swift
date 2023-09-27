//
//  AddNewExpenses.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-25.
//


import SwiftUI

struct AddNewExpenses: View {
    @EnvironmentObject var allTypesManager: AllTypesManager
    @State private var selectedDate = Date()
    @State private var type = ""
    @State private var category = ""
    @State private var remark = ""
    @State private var amount = ""
    @State private var isShowingListView = false // State to control navigation
    
    let typeOptions = ["Income", "Expense"]
    @State private var selectedType = "Income" // Initial selection
    

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Expense Details")) {
                    //TextField("Type", text: $type)
                    Picker("Type", selection: $selectedType) {
                                            ForEach(typeOptions, id: \.self) { option in
                                                Text(option)
                                            }
                                        }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    
                    TextField("Category", text: $category)
                    DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                    TextField("Remark", text: $remark)
                    TextField("Amount", text: $amount)
                }

                Section {
                    Button(action: {
                        addExpense()
                    }) {
                        Text("Save")
                    }
                }
            }
            .navigationBarTitle("Add New Expenses")
                        .sheet(isPresented: $isShowingListView, content: {
                        
                            ListView()
                        })
        }
    }

//    func addExpense() {
//        // Create a new expense object
//        let newExpense = AllTypes(
//            id: UUID().uuidString,
//            type: type,
//            remark: remark,
//            date: selectedDate,
//            amount: amount,
//            category: category
//        )
//
//        allTypesManager.addData(id: newExpense.id, type: newExpense.type, category: newExpense.category, date: newExpense.date, remark: newExpense.remark, amount: newExpense.amount)
//
//        // Show the list view after adding the expense
//                isShowingListView = true
//
//        // Clear form fields after adding the expense
//        type = ""
//        category = ""
//        remark = ""
//        amount = "'"
//        selectedDate = Date()
//
//
//    }
    
    func addExpense() {
        // Convert the amount string to a Double
        if let amountDouble = Double(amount) {
            // Create a new expense object with the converted amount
            let newExpense = AllTypes(
                id: UUID().uuidString,
                type: type,
                remark: remark,
                date: selectedDate,
                amount: amountDouble, // Use the converted amount
                category: category
            )

            // Add the new expense to your data manager or Firestore
            // allTypesManager.addData(id: newExpense.id, type: newExpense.type, category: newExpense.category, date: newExpense.date, remark: newExpense.remark, amount: newExpense.amount)

            // Show the list view after adding the expense
            isShowingListView = true

            // Clear form fields after adding the expense
            type = ""
            category = ""
            remark = ""
            amount = ""
            selectedDate = Date()
        } else {
            // Handle the case where the amount cannot be converted to a double
            // You can show an alert or perform error handling here
            print("Invalid amount format")
        }
    }

}

struct AddNewExpenses_Previews: PreviewProvider {
    static var previews: some View {
        AddNewExpenses()
    }
}


