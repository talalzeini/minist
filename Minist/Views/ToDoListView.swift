//
//  TasksView.swift
//  Minist
//
//  Created by Talal El Zeini on 9/1/24.
//

import SwiftUI

struct ToDoListView: View {
    @State private var filter: FilterType = .all
    @State private var scrollToTop = false
    @ObservedObject var viewModel: ToDoListViewModel
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    private var filteredTasks: [Task] {
        let calendar = Calendar.current
        switch filter {
        case .completed:
            return viewModel.tasks.filter { $0.isCompleted }
        case .notCompleted:
            return viewModel.tasks.filter { !$0.isCompleted }
        case .today:
            return viewModel.tasks.filter { calendar.isDateInToday($0.dateCreated) }
        case .yesterday:
            return viewModel.tasks.filter { calendar.isDateInYesterday($0.dateCreated) }
        case .all:
            return viewModel.tasks
        }
    }

    private var navigationBarTitle: String {
        switch filter {
        case .all: return "Tasks"
        case .completed: return "Completed Tasks"
        case .notCompleted: return "Uncompleted Tasks"
        case .today: return "Today's Tasks"
        case .yesterday: return "Yesterday's Tasks"
        }
    }

    var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
                VStack(spacing: 0) {
                    if filteredTasks.isEmpty {
                        EmptyStateView(message: "No \(navigationBarTitle.lowercased())")
                    } else {
                        TaskListView(filteredTasks: filteredTasks, proxy: proxy, scrollToTop: $scrollToTop, viewModel: viewModel)
                    }
                    InputView(
                        addTaskAction: {
                            viewModel.addTask(isCompleted: filter == .completed)
                            scrollToTop = true
                        },
                        newTaskTitle: $viewModel.newTaskTitle,
                        isDarkMode: isDarkMode
                    )
                }
                .navigationBarTitle(navigationBarTitle, displayMode: .inline)
                .navigationBarItems(
                    leading: Button(action: {
                        isDarkMode.toggle()
                    }) {
                        Image(systemName: isDarkMode ? "circle.lefthalf.filled" : "circle.lefthalf.filled.inverse")
                            .foregroundStyle(isDarkMode ? .white : .black)
                    },
                    trailing: FilterMenuView(filter: $filter, isDarkMode: isDarkMode)
                )
            }
        }
    }
}
