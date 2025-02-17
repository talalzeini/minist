//
// TaskRowView.swift
// Minist
//
// Created by Talal El Zeini on 2/16/25.
//

import SwiftUI

struct TaskRowView: View {
    let task: Task
    @ObservedObject var viewModel: ToDoListViewModel
    @Binding var scrollToTop: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.headline)
                Text("Created on \(DateFormatter.customDateFormatter.string(from: task.dateCreated))")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            
            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                .font(.system(size: 25))
                .onTapGesture {
                    if let index = viewModel.tasks.firstIndex(where: { $0.id == task.id }) {
                        viewModel.completeTask(at: index)
                        scrollToTop = false
                    }
                }
        }
        .contentShape(Rectangle())
        .padding(.vertical, 8)
    }
}
