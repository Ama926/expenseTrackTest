//
//  BarChartView.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-25.
//

//import SwiftUI
//
//struct BarChartView: View {
//    let dataPoints: [DataPoint]
//
//    var body: some View {
//        VStack {
//            ForEach(dataPoints, id: \.category) { dataPoint in
//                BarView(dataPoint: dataPoint)
//                    .padding(.bottom, 8)
//            }
//        }
//    }
//}
//
//struct BarView: View {
//    let dataPoint: DataPoint
//
//    var body: some View {
//        VStack {
//            Text(dataPoint.category)
//                .font(.caption)
//
//            Rectangle()
//                .fill(dataPoint.color)
//                .frame(height: CGFloat(dataPoint.value), alignment: .center)
//
//            Text(String(format: "%.2f", dataPoint.value))
//                .font(.caption)
//        }
//    }
//}
