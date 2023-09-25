//
//  ListView.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-25.
//

import SwiftUI
import simd

struct ListView: View {
    @EnvironmentObject var allTypesManager: AllTypesManager
    
    var body: some View {
        NavigationView {
            List(allTypesManager.allTypes, id: \.id) { allTypes in
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
                // Add button action
            }) {
                Image(systemName: "plus")
            })
        }
    }

    // Helper function to determine text color based on type
    func textColorForType(_ type: String) -> Color {
        if type == "income" {
            return .green
        } else if type == "expense" {
            return .red
        } else {
            return .primary // Default color for other types
        }
    }


    // Helper function to format the date
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
