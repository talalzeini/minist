//
//  FilterMenuView.swift
//  Minist
//
//  Created by Talal El Zeini on 9/2/24.
//

import SwiftUI

enum FilterType: Equatable {
    case all, completed, notCompleted
}

struct FilterMenuView: View {
    @Binding var filter: FilterType
    var isDarkMode: Bool

    var body: some View {
        Menu {
            Button(action: {
                filter = .all
            }) {
                Label("All", systemImage: filter == .all ? "checkmark.circle.fill" : "")
            }
            Button(action: {
                filter = .completed
            }) {
                Label("Completed", systemImage: filter == .completed ? "checkmark.circle.fill" : "")
            }
            Button(action: {
                filter = .notCompleted
            }) {
                Label("Uncompleted", systemImage: filter == .notCompleted ? "checkmark.circle.fill" : "")
            }
        } label: {
            Image(systemName: "line.3.horizontal.decrease.circle")
                .foregroundColor(isDarkMode ? .white : .black)
                .font(.system(size: 20))
        }
    }
}
