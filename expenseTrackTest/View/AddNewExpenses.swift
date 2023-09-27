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

    func addExpense() {
        // Convert the amount string to a Double
        if let amountDouble = Double(amount) {
            // Create a new expense object with the converted amount
            let newExpense = AllTypes(
                id: UUID().uuidString,
                type: selectedType,
                remark: remark,
                date: selectedDate,
                amount: amountDouble, // Use the converted amount
                category: category
            )

            // Add the new expense to your data manager or Firestore
            allTypesManager.addData(id: newExpense.id, type: newExpense.type, category: newExpense.category, date: newExpense.date, remark: newExpense.remark, amount: Int(newExpense.amount))

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
//
//

//import SwiftUI
//import FirebaseFirestore
//
//import Foundation
//import FirebaseFirestoreSwift
//
//struct Category: Identifiable, Decodable {
//    var id: String // Assuming you have an identifier field
//    var name: String
//}
//
//
//struct AddNewExpenses: View {
//    @EnvironmentObject var allTypesManager: AllTypesManager
//    @State private var selectedDate = Date()
//    @State private var type = ""
//    @State private var selectedCategory = ""
//    @State private var remark = ""
//    @State private var amount = ""
//    @State private var isShowingListView = false // State to control navigation
//
//    @State private var categories: [Category] = [] // Array to store categories
//
//    let typeOptions = ["Income", "Expense"]
//    @State private var selectedType = "Income" // Initial selection
//
//    // Firestore reference and listener
//    private var db = Firestore.firestore()
//    private var categoriesListener: ListenerRegistration?
//
//    init() {
//        // Fetch categories from Firestore when the view is initialized
//        fetchCategories()
//    }
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Expense Details")) {
//                    Picker("Type", selection: $selectedType) {
//                        ForEach(typeOptions, id: \.self) { option in
//                            Text(option)
//                        }
//                    }
//                    .pickerStyle(MenuPickerStyle())
//                    .padding()
//
//                    // Dropdown menu for categories
//                    Picker("Category", selection: $selectedCategory) {
//                        ForEach(categories, id: \.name) { category in
//                            Text(category.name)
//                        }
//                    }
//                    .pickerStyle(MenuPickerStyle())
//                    .padding()
//
//                    DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
//                    TextField("Remark", text: $remark)
//                    TextField("Amount", text: $amount)
//                }
//
//                Section {
//                    Button(action: {
//                        addExpense()
//                    }) {
//                        Text("Save")
//                    }
//                }
//            }
//            .navigationBarTitle("Add New Expenses")
//            .sheet(isPresented: $isShowingListView, content: {
//                ListView()
//            })
//        }
//    }
//
//    // Fetch categories from Firestore
//    private mutating func fetchCategories() {
//        categoriesListener = db.collection("categories").addSnapshotListener { [weak self] querySnapshot, error in
//            guard let self = self else {
//                // Handle the case where self has been deallocated
//                return
//            }
//
//            guard let documents = querySnapshot?.documents else {
//                print("Error fetching categories: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//
//            self.categories = documents.compactMap { queryDocumentSnapshot in
//                do {
//                    let category = try queryDocumentSnapshot.data(as: Category.self)
//                    return category
//                } catch {
//                    print("Error decoding category: \(error.localizedDescription)")
//                    return nil
//                }
//            }
//        }
//    }
//
//
//    // Cleanup the listener when the view is deinitialized
////    deinit {
////        categoriesListener?.remove()
// //   }
//
//    // Add expense function
//    func addExpense() {
//        // Convert the amount string to a Double
//        if let amountDouble = Double(amount) {
//            // Create a new expense object with the converted amount
//            let newExpense = AllTypes(
//                id: UUID().uuidString,
//                type: selectedType, // Use the selectedType instead of type
//                remark: remark,
//                date: selectedDate,
//                amount: amountDouble, // Use the converted amount
//                category: selectedCategory // Use the selectedCategory instead of category
//            )
//
//            allTypesManager.addData(id: newExpense.id, type: newExpense.type, category: newExpense.category, date: newExpense.date, remark: newExpense.remark, amount: Int(newExpense.amount))
//
//            // Show the list view after adding the expense
//            isShowingListView = true
//
//            // Clear form fields after adding the expense
//            selectedType = "Income"
//            selectedCategory = ""
//            remark = ""
//            amount = ""
//            selectedDate = Date()
//        } else {
//            // Handle the case where the amount cannot be converted to a double
//            // You can show an alert or perform error handling here
//            print("Invalid amount format")
//        }
//    }
//}
