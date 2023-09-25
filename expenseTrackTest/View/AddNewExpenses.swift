//
//  AddNewExpenses.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-25.
//

//import SwiftUI
//
//struct AddNewExpenses: View {
//    @EnvironmentObject var allTypesManager: AllTypesManager
//    @State private var newData = ""
//
//    var body: some View {
//        VStack{
//            TextField("Expense", text: $newData)
//
//            Button{
//                allTypesManager.addData(type: newData, remark: <#T##String#>, date: <#T##Date#>, amount: <#T##Double#>, category: <#T##String#>)
//            } label: {
//                Text("Save")
//            }
//        }
//        .padding()
//    }
//}
//
//struct AddNewExpenses_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNewExpenses()
//    }
//}

import SwiftUI

struct AddNewExpenses: View {
    @EnvironmentObject var allTypesManager: AllTypesManager
    @State private var selectedDate = Date()
    @State private var type = ""
    @State private var category = ""
    @State private var remark = ""
    @State private var amount = ""
    @State private var isShowingListView = false // State to control navigation
    

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Expense Details")) {
                    TextField("Type", text: $type)
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
            .navigationBarTitle("Add Expense")
                        .sheet(isPresented: $isShowingListView, content: {
                            // Replace "ListView()" with the actual view you want to navigate to
                            ListView()
                        })
        }
    }

    func addExpense() {
        // Create a new expense object
        let newExpense = AllTypes(
            id: UUID().uuidString,
            type: type,
            remark: remark,
            date: selectedDate,
            amount: 250,
            category: category
        )

        allTypesManager.addData(id: newExpense.id, type: newExpense.type, category: newExpense.category, date: newExpense.date, remark: newExpense.remark, amount: 250)
        
        // Show the list view after adding the expense
                isShowingListView = true
        
        // Clear form fields after adding the expense
        type = ""
        category = ""
        remark = ""
        amount = "'"
        selectedDate = Date()
        
        
    }
}

struct AddNewExpenses_Previews: PreviewProvider {
    static var previews: some View {
        AddNewExpenses()
    }
}


//

