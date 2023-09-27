//
//  ListView.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-25.
//
//


import SwiftUI
import simd

struct ListView: View {
    @EnvironmentObject var allTypesManager: AllTypesManager
    @State private var isAddingNewExpense = false

    var body: some View {
        NavigationView {
            List(allTypesManager.allTypes, id: \.id) { allTypes in
                // Your list content here
                VStack(alignment: .leading) {
                    Text("Type: ")
                        .foregroundColor(textColorForType(allTypes.type))
                    Text(allTypes.type)
                        .font(.headline)
                        .foregroundColor(textColorForType(allTypes.type))
                    Text("Remark: \(allTypes.remark)")
                    Text("Date: \(formattedDate(allTypes.date))")
                    Text("Amount: \(String(format: "%.2f", allTypes.amount))")
                    Text("Category: \(allTypes.category)")
                }
            }
            .navigationTitle("All")
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
                                // Add your save logic here
                                isAddingNewExpense = false
                            }
                        )
                        .navigationTitle("Add New Expenses")
                }
            }
        }
        
    }
    
    func textColorForType(_ type: String) -> Color {
            if type == "Income" {
                return .green
            } else if type == "Expenses" {
                return .red
            } else {
                return .primary // Default color for other types
            }
        }


    func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy" // Customize the date format as needed
        return dateFormatter.string(from: date)
    }
}
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
