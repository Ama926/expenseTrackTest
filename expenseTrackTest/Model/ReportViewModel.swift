//
//  ReportViewModel.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-28.
//

import SwiftUI
import Firebase

class ReportViewModel: ObservableObject {
    private var db = Firestore.firestore()
    
    @Published var expenses: [Expense] = []
    
    init() {
        fetchExpenses()
    }
    
    func fetchExpenses() {
            db.collection("expenses").addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error fetching expenses: \(error.localizedDescription)")
                    return
                }
                
                self.expenses = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: Expense.self)
                } ?? []
            }
        }
}
