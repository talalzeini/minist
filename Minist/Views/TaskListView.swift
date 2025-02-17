//
// TaskListView.swift
// Minist
//
// Created by Talal El Zeini on 2/16/25.
//

import SwiftUI

struct TaskListView: View {
    let filteredTasks: [Task]
    let proxy: ScrollViewProxy
    @Binding var scrollToTop: Bool
    @ObservedObject var viewModel: ToDoListViewModel
    
    var body: some View {
        List {
            ForEach(filteredTasks.reversed()) { task in
                TaskRowView(task: task, viewModel: viewModel, scrollToTop: $scrollToTop)
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            viewModel.deleteTask(task)
                            scrollToTop = false
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
            }
        }
        .onChange(of: viewModel.tasks) { _, newTasks in
            if let lastTask = newTasks.last, scrollToTop {
                withAnimation {
                    proxy.scrollTo(lastTask.id, anchor: .top)
                }
            }
        }
    }
}
