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

                    DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 1)
                                .foregroundColor(.black)
                        )
                        .padding(.horizontal)
                        

                    TextField("Remark", text: $remark)
//                        .foregroundColor(.black)
//                        .textFieldStyle(.plain)
                        .foregroundColor(.black)
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 1)
                                .foregroundColor(.black)
                        )
                        .padding(.horizontal)
                        
                    TextField("Amount", text: $amount)
                        .foregroundColor(.black)
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 1)
                                .foregroundColor(.black)
                        )
                        .padding(.horizontal)
                }

               // Section {
                    Button(action: {
                        addExpense()
                    }) {
                        Text("SAVE")
                            .bold()
                            .frame(maxWidth: .infinity, maxHeight: 100)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color.black)
                            )
                            .foregroundColor(.white)
                            
                    }
                    
                }
      //      }
            
            .navigationBarTitle("Add New Expenses")
            .sheet(isPresented: $isShowingListView, content: {
                ListView()
            })
            
//            NavigationLink("", destination: ListView(), isActive: $isShowingListView)
//                        .hidden() // Hide the actual link button
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

           
            //isShowingListView = true
           // ListView()

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
