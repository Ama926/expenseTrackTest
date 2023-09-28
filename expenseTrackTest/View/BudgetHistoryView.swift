//
//  BudgetHistoryView.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-28.
//

import SwiftUI

struct BudgetHistoryView: View {
    @State private var budgets: [Budget] = []
    private let firestoreService = FirestoreService()
    
    var body: some View {
        Text("Hello, Budget!")
    }
}

struct BudgetHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetHistoryView()
    }
}
