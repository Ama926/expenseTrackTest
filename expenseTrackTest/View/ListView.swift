//
//  ListView.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-25.
//
//

//
//import SwiftUI
//import simd
//
//struct ListView: View {
//    @EnvironmentObject var allTypesManager: AllTypesManager
//    @State private var isAddingNewExpense = false
//
//    var body: some View {
//        NavigationView {
//            List(allTypesManager.allTypes, id: \.id) { allTypes in
//                // Your list content here
//                VStack(alignment: .leading) {
//                    Text("Type: ")
//                        .foregroundColor(textColorForType(allTypes.type))
//                    Text(allTypes.type)
//                        .font(.headline)
//                        .foregroundColor(textColorForType(allTypes.type))
//                    Text("Remark: \(allTypes.remark)")
//                    Text("Date: \(formattedDate(allTypes.date))")
//                    Text("Amount: \(String(format: "%.2f", allTypes.amount))")
//                    Text("Category: \(allTypes.category)")
//                }
//            }
//            .navigationTitle("All")
//            .navigationBarItems(trailing: Button(action: {
//                isAddingNewExpense.toggle()
//            }) {
//                Image(systemName: "plus")
//            })
//            .sheet(isPresented: $isAddingNewExpense) {
//                NavigationView {
//                    AddNewExpenses()
//                        .navigationBarItems(
//                            leading: Button("Cancel") {
//                                isAddingNewExpense = false
//
//                            },
//                            trailing: Button("Save") {
//                                // Add your save logic here
//                                isAddingNewExpense = false
//                            }
//                        )
//                        .navigationTitle("Add New Expenses")
//                }
//            }
//        }
//
//    }
//
//    func textColorForType(_ type: String) -> Color {
//            if type == "Income" {
//                return .green
//            } else if type == "Expenses" {
//                return .red
//            } else {
//                return .primary // Default color for other types
//            }
//        }
//
//
//    func formattedDate(_ date: Date) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM/dd/yyyy" // Customize the date format as needed
//        return dateFormatter.string(from: date)
//    }
//}
//struct ListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListView()
//    }
//}


//
//@main
//class AppDelegate: UIResponder, UIApplicationDelegate {
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        FirebaseApp.configure()
//        return true
//    }
//}

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct Expenses: Identifiable {
    let id: String
    let date: Date
    let amount: Double
    let type: String
    let category: String
    let remark: String
}

func dateFromTimestamp(_ timestamp: Timestamp) -> Date {
    return timestamp.dateValue()
}

struct ListView: View {
    @EnvironmentObject var allTypesManager: AllTypesManager
    @State private var isAddingNewExpense = false
    @State private var selectedTab: Tab = .currentMonth // Initially set to Current Month

    enum Tab {
        case currentMonth
        case currentYear
    }

    var body: some View {
        
        ZStack{
            Color.black.ignoresSafeArea()
            NavigationView{
              
                VStack {
                    Picker("Filter", selection: $selectedTab) {
                        Text("Current Month").tag(Tab.currentMonth)
                        Text("Current Year").tag(Tab.currentYear)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
           
                    List(filteredExpenses, id: \.id) { expenses in
                        // list content
                        ExpenseView(expenses: expenses)
                    }
                    .navigationTitle("All Records")
                    .navigationBarItems(trailing: Button(action: {
                        isAddingNewExpense.toggle()
                    }) {
                        Image(systemName: "plus")
                    })
                    .sheet(isPresented: $isAddingNewExpense) {
                        NavigationView {
                            
                            AddNewExpenses()
                                .navigationBarItems(
                                    leading: Button("Cancel") {
                                        isAddingNewExpense = false
                                    },
                                    trailing: Button("Save") {
                                        isAddingNewExpense = false
                                    }
                                )
                                //.navigationTitle("Add New Expenses")
                                //.background(Color.black)
                        }
                    }
                }
            }
        }
        .ignoresSafeArea(.all)
        
    }
    
    var filteredExpenses: [Expenses] {
            let currentDate = Date()
            let calendar = Calendar.current

            switch selectedTab {
            case .currentMonth:
                let currentMonth = calendar.component(.month, from: currentDate)
                let currentYear = calendar.component(.year, from: currentDate)

                return allTypesManager.allTypes
                    .compactMap { allTypes in
                        guard
                            let timestamp = allTypes.date as? Date,
                            let amount = allTypes.amount as? Double,
                            let type = allTypes.type as? String,
                            let category = allTypes.category as? String,
                            let remark = allTypes.remark as? String
                        else {
                            // Print an error or add some error handling here
                            return nil
                        }

                        return Expenses(
                            id: allTypes.id,
                            date: timestamp,
                            amount: amount,
                            type: type,
                            category: category,
                            remark: remark
                        )
                    }
                    .filter { expenses in
                        let expenseMonth = calendar.component(.month, from: expenses.date)
                        let expenseYear = calendar.component(.year, from: expenses.date)
                        return expenseMonth == currentMonth && expenseYear == currentYear
                    }

            case .currentYear:
                let currentYear = calendar.component(.year, from: currentDate)

                return allTypesManager.allTypes
                    .compactMap { allTypes in
                        guard
                            let timestamp = allTypes.date as? Date,
                            let amount = allTypes.amount as? Double,
                            let type = allTypes.type as? String,
                            let category = allTypes.category as? String,
                            let remark = allTypes.remark as? String
                        else {
                            // Print an error or add some error handling here
                            return nil
                        }

                        return Expenses(
                            id: allTypes.id,
                            date: timestamp,
                            amount: amount,
                            type: type,
                            category: category,
                            remark: remark
                        )
                    }
                    .filter { expenses in
                        let expenseYear = calendar.component(.year, from: expenses.date)
                        return expenseYear == currentYear
                    }
            }
        }
}

struct ExpenseView: View {
    
    let expenses: Expenses
    
//    var body: some View {
//        VStack(alignment: .leading) {
//          //  Text("Type: ")
//            Text(expenses.type)
//                .font(.headline)
//                .foregroundColor(textColorForType(expenses.type))
//            Text("\(expenses.remark)")
//            Text("\(formattedDate(expenses.date))")
//            Text("\(String(format: "%.2f", expenses.amount))")
//            Text("\(expenses.category)")
//        }
//        .padding()
//    }
    
    
    var body: some View {
       
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    if expenses.type == "Income" {
                        Image(systemName: "arrow.down.circle.fill")
                            .foregroundColor(.green)
                    } else if expenses.type == "Expense" {
                        Image(systemName: "arrow.up.circle.fill")
                            .foregroundColor(.red)
                    }
                    Text(expenses.type)
                        .font(.headline)
                        .foregroundColor(textColorForType(expenses.type))
                }
                Text("Remark: \(expenses.remark)")
                    .foregroundColor(.black)
                
              //  Spacer().frame(height: 50)
                Text("Date: \(formattedDate(expenses.date))")
                    .foregroundColor(.black)
                
             //   Spacer().frame(height: 50)
                Text("Amount: \(String(format: "%.2f", expenses.amount))")
                    .foregroundColor(.black)
                
            //    Spacer().frame(height: 50)
                Text("Category: \(expenses.category)")
                    .foregroundColor(.black)
            }
        
            .padding(5)
            .background(Color.white) // Set the view's background to black
            .cornerRadius(10)
        
    }


    
    func textColorForType(_ type: String) -> Color {
        if type == "Income" {
            return .green
        } else if type == "Expense" {
            return .red
        } else {
            return .primary
        }
    }

    func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: date)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
