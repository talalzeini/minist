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
            // Pinned Tasks Section
            if (!filteredTasks.filter { $0.isPinned }.isEmpty) {
                Section(header: Text("Pinned Tasks")) {
                    ForEach(filteredTasks.reversed().filter { $0.isPinned }) { task in
                        TaskRowView(task: task, viewModel: viewModel, scrollToTop: $scrollToTop)
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    viewModel.deleteTask(task)
                                    scrollToTop = false
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                
                                Button {
                                    viewModel.pinTask(at: viewModel.tasks.firstIndex { $0.id == task.id } ?? 0)
                                    scrollToTop = false
                                } label: {
                                    Label(task.isPinned ? "Unpin" : "Pin", systemImage: task.isPinned ? "pin.slash.fill" : "pin.fill")
                                }
                                .tint(task.isPinned ? .orange : .blue)
                            }
                    }
                }
            }
            
            if (!filteredTasks.filter { !$0.isPinned }.isEmpty) {
                Section(header: !filteredTasks.filter { $0.isPinned }.isEmpty ? Text("Other Tasks") : Text("")) {
                    ForEach(filteredTasks.reversed().filter { !$0.isPinned }) { task in
                        TaskRowView(task: task, viewModel: viewModel, scrollToTop: $scrollToTop)
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    viewModel.deleteTask(task)
                                    scrollToTop = false
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                
                                Button {
                                    viewModel.pinTask(at: viewModel.tasks.firstIndex { $0.id == task.id } ?? 0)
                                    scrollToTop = false
                                } label: {
                                    Label(task.isPinned ? "Unpin" : "Pin", systemImage: task.isPinned ? "pin.slash.fill" : "pin.fill")
                                }
                                .tint(task.isPinned ? .orange : .blue)
                            }
                    }
                }
            }
        }
        .alert(isPresented: $viewModel.showMaxPinsAlert) {
            Alert(
                title: Text("Limit Reached"),
                message: Text("You can only pin up to 3 tasks at a time."),
                dismissButton: .default(Text("OK"))
            )
        }
        .listRowSpacing(20)
        .onChange(of: viewModel.tasks) { _, newTasks in
            if let lastTask = newTasks.last, scrollToTop {
                withAnimation {
                    proxy.scrollTo(lastTask.id, anchor: .top)
                }
            }
        }
    }
}
