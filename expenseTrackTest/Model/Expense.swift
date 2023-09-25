//
//  Expense.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-25.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

struct Expense: Identifiable, Decodable {
    @DocumentID var id: String?
    let amount: Double
    let category: String
    let date: Timestamp // Use Firestore Timestamp for date

    // Other properties and initializers, if needed

    // If you want to convert Firestore Timestamp to Swift Date, you can add a computed property like this:
    var dateAsSwiftDate: Date {
        return date.dateValue()
    }
}

