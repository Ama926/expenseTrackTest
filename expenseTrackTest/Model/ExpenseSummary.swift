//
//  ExpenseSummary.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-28.
//

import SwiftUI
import Firebase

class ExpenseViewModel: ObservableObject {
    @Published var expenses: [Expense] = []
    @Published var totalIncome: Double = 0
    @Published var totalExpenses: Double = 0

    private var db = Firestore.firestore()

    init() {
        fetchExpenses()
    }

    func fetchExpenses() {
        db.collection("AllTypes").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching expenses: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            
            self.expenses = documents.compactMap { document in
                if let expense = Expense(document: document) {
                    return expense
                } else {
                    return nil
                }
            }
            
            // Calculate total income and expenses
            self.totalIncome = self.expenses.filter { $0.type == "Income" }.reduce(0) { $0 + $1.amount }
            self.totalExpenses = self.expenses.filter { $0.type == "Expense" }.reduce(0) { $0 + $1.amount }
        }
    }
}

