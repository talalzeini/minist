//
// StatsRectangleView.swift
// Minist
//
// Created by Tech With Talal on 4/6/25.
//

import SwiftUI

struct StatsRectangleView: View {
    let title: String
    let count: Int
    let total: Int
    let dateRange: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.title)
                    .bold()
                Text(dateRange)
                    .font(.subheadline)
                Text("\(count)/\((total + count)) Tasks Completed")
                    .font(.subheadline)
            }
            .padding(.leading)
            
            Spacer()
            
            VStack {
                CircleIndicatorView(count: count, total: total)
            }
            .padding(.trailing)
        }
        .frame(height: 120)
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray6))
        .cornerRadius(16)
    }
}
