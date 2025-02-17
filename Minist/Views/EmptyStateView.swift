//
// EmptyStateView.swift
// Minist
//
// Created by Talal El Zeini on 2/16/25.
//

import SwiftUI

struct EmptyStateView: View {
    let message: String
    
    var body: some View {
        Spacer()
        Text(message)
            .font(.headline)
            .foregroundColor(.gray)
            .padding()
        Spacer()
    }
}
