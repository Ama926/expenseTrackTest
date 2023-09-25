//
//  BarView.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-25.
//

// BarView.swift
import SwiftUI

struct BarView: View {
    let expense: TestExp
    let maxAmount: Double = 300.0 // Adjust the maximum value as needed
    
    var body: some View {
        VStack {
            Text(expense.category)
                .font(.caption)
            
            GeometryReader { geometry in
                ZStack(alignment: .bottom) {
                    Capsule()
                        .frame(width: 30, height: CGFloat(expense.amount) / maxAmount * geometry.size.height)
                        .foregroundColor(Color.blue)
                    
                    Text(String(format: "$%.2f", expense.amount))
                        .font(.caption)
                        .foregroundColor(.white)
                }
            }
        }
    }
}
