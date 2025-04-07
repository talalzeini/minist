//
// CircularIndicatorView.swift
// Minist
//
// Created by Tech With Talal on 4/6/25.
//

import SwiftUI

struct CircleIndicatorView: View {
    let count: Int
    let total: Int
    
    var progress: CGFloat {
        guard total > 0 else { return 1 }
        return CGFloat(count) / (CGFloat(total) + CGFloat(count))
    }
    
    var progressColor: Color {
        switch progress {
        case 0..<0.5:
            return .red
        case 0.5..<0.75:
            return .yellow
        default:
            return .green
        }
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 5)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(progressColor, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                .rotationEffect(.degrees(-90))
            
            Text("\(count)")
                .font(.title)
                .foregroundColor(progressColor)
                .bold()
        }
        .frame(width: 75, height: 75)
        .padding(.horizontal)
    }
}
