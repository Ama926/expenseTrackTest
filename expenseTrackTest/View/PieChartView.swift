//
//  PieChartView.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-28.
//
import SwiftUI

//struct PieChartView: View {
//    let dataPoints: [DataPoint]
//    let categoryColors: [String: Color]
//
//    var body: some View {
//        ZStack {
//            ForEach(dataPoints) { dataPoint in
//                PieChartSegmentView(dataPoint: dataPoint,totalValue: totalValue(dataPoints: dataPoints), color: Color.random())
//            }
//        }
//    }
//
//    private func totalValue(dataPoints: [DataPoint]) -> Double {
//        return dataPoints.reduce(0) { $0 + $1.value }
//    }
//}
//
//struct PieChartSegmentView: View {
//    let dataPoint: DataPoint
//    let totalValue: Double
//    let color: Color // Removed the random color assignment
//
//    var body: some View {
//        GeometryReader { geometry in
//            Path { path in
//                let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
//                let radius = min(geometry.size.width, geometry.size.height) / 2
//                let startAngle = Angle(degrees: 0)
//                let endAngle = Angle(radians: 2 * .pi * (dataPoint.value / totalValue))
//
//                path.move(to: center)
//                path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
//                path.closeSubpath()
//            }
//            .fill(color) // Use the color property here
//        }
//    }
//}
//


struct PieChartView: View {
    let dataPoints: [DataPoint]
    let categoryColors: [String: Color]
    
    var body: some View {
        ZStack {
            ForEach(dataPoints) { dataPoint in
                //PieChartSegmentView(dataPoint: dataPoint, totalValue: totalValue(dataPoints: dataPoints))
                PieChartSegmentView(dataPoint: dataPoint,totalValue: totalValue(dataPoints: dataPoints), color: categoryColors)
            }
        }
    }
    
    private func totalValue(dataPoints: [DataPoint]) -> Double {
        return dataPoints.reduce(0) { $0 + $1.value }
    }
}

struct PieChartSegmentView: View {
    let dataPoint: DataPoint
    let totalValue: Double
    let color: [String: Color]
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                let radius = min(geometry.size.width, geometry.size.height) / 2
                let startAngle = Angle(degrees: 0)
                let endAngle = Angle(degrees: 360 * (dataPoint.value / totalValue))
                
                
                path.move(to: center)
                path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                path.closeSubpath()
            }
            .fill(dataPoint.color)
        }
    }
}
