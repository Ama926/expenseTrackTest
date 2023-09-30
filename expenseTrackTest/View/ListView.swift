//
//  ListView.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-25.
//
//

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
    @State private var selectedTab: Tab = .currentWeek

    enum Tab {
        case currentWeek
        case currentMonth
        case currentYear
        
    }

    var body: some View {
        ZStack {
            //Color.black.ignoresSafeArea()
            Color.black
            NavigationView {
                VStack {
                    Picker("Filter", selection: $selectedTab) {
                        Text("Current Month").tag(Tab.currentMonth)
                        Text("Current Year").tag(Tab.currentYear)
                        Text("Current Week").tag(Tab.currentWeek) // Add this option
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
           
                    List(filteredExpenses, id: \.id) { expenses in
                        ExpenseView(expenses: expenses)
                    }
                    .navigationTitle("All Records")
                    
//                    .navigationBarItems(trailing: Button(action: {
//                        isAddingNewExpense.toggle()
//                    }) {
//                        Image(systemName: "plus")
//                    })
                    .sheet(isPresented: $isAddingNewExpense) {
                        NavigationView {
                            AddNewExpenses()
                                .navigationBarItems(
                                    leading: Button("Cancel") {
                                        isAddingNewExpense = false
                                    }
                                )
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
        case .currentWeek:
            // Calculate the start date and end date of the current week
            if let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate)),
               let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) {
                
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
                        return startOfWeek...endOfWeek ~= expenses.date // Filter by date range for the current week
                    }
            } else {
                return [] // Return an empty array if the calculation fails
            }
            
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

    var body: some View {
        ZStack{
            Color.black
            VStack(alignment: .leading, spacing: 5) {
                HStack(alignment: .top) {
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
                    .foregroundColor(.white)
                    .alignmentGuide(.leading) { dimension in
                                            dimension[HorizontalAlignment.leading]
                                        }
                Text("Date: \(formattedDate(expenses.date))")
                    .foregroundColor(.white)
                    .alignmentGuide(.leading) { dimension in
                                            dimension[HorizontalAlignment.leading]
                                        }
                Text("Amount: \(String(format: "%.2f", expenses.amount))")
                    .foregroundColor(.white)
                    .alignmentGuide(.leading) { dimension in
                                            dimension[HorizontalAlignment.leading]
                                        }
                Text("Category: \(expenses.category)")
                    .foregroundColor(.white)
                    .alignmentGuide(.leading) { dimension in
                                            dimension[HorizontalAlignment.leading]
                                        }
            }
            .padding(5)
            .background{
                Color.black
                    .opacity(0.5)
            }
            
            .cornerRadius(10)
        }
        
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
