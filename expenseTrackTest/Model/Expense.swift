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
    let type: String
    let remark: String
    let amount: Double
    let category: String
    let date: Timestamp

    init?(document: DocumentSnapshot) {
        guard let data = document.data() else {
            return nil
        }
        
        guard let type = data["type"] as? String,
              let remark = data["remark"] as? String,
              let amount = data["amount"] as? Double,
              let category = data["category"] as? String,
              let date = data["date"] as? Timestamp
        else {
            return nil
        }

        self.type = type
        self.remark = remark
        self.amount = amount
        self.category = category
        self.date = date
    }
    
    var dateAsSwiftDate: Date {
        return date.dateValue()
    }
}

