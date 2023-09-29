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
    let categoryOptions = ["Transport", "Food", "Utilities", "Education", "Income"]
    @State private var selectedType = "Income" // Initial selection
    @State private var selectedCategory = "Transport"
    
    var body: some View {
        NavigationView {
            Form {
               
                Section(header: Text("Expense Details")) {
                    Picker("Type", selection: $selectedType) {
                        ForEach(typeOptions, id: \.self) { option in
                            Text(option)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    
                    Picker("Category", selection: $selectedCategory){
                        ForEach(categoryOptions, id:\.self){ option in
                            Text(option)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()

//                    TextField("Category", text: $category)
//                        .foregroundColor(.black)
//                        .textFieldStyle(.plain)
//                        .placeholder(when: category.isEmpty) {
//                            Text("Category")
//                                .foregroundColor(.white)
//                                .bold()
//                        }

                    DatePicker("Date", selection: $selectedDate, displayedComponents: .date)

                    TextField("Remark", text: $remark)
                        .foregroundColor(.black)
                        .textFieldStyle(.plain)
                        
                    TextField("Amount", text: $amount)
                        .foregroundColor(.black)
                        .textFieldStyle(.plain)
                }

               // Section {
                    Button(action: {
                        addExpense()
                    }) {
                        Text("SAVE")
                            .bold()
                            .frame(width: 200, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.linearGradient(colors: [.blue, .green], startPoint: .top, endPoint: .bottomTrailing))
                            )
                            .foregroundColor(.white)
                    }
                    
              //  }
            }
            
            .navigationBarTitle("Add New Expenses")
            .sheet(isPresented: $isShowingListView, content: {
                ListView()
            })
        }
    }


    func addExpense() {
        
        if let amountDouble = Double(amount) {
            
            let newExpense = AllTypes(
                id: UUID().uuidString,
                type: selectedType,
                remark: remark,
                date: selectedDate,
                amount: amountDouble,
                category: selectedCategory
            )

            allTypesManager.addData(id: newExpense.id, type: newExpense.type, category: newExpense.category, date: newExpense.date, remark: newExpense.remark, amount: Int(newExpense.amount))

           
            isShowingListView = true

            type = ""
            selectedCategory = ""
            remark = ""
            amount = ""
            selectedDate = Date()
        } else {
            
            print("Invalid amount format")
        }
    }

}

struct AddNewExpenses_Previews: PreviewProvider {
    static var previews: some View {
        AddNewExpenses()
    }
}
