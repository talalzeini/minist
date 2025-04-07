//
// ProgressView.swift
// Minist
//
// Created by Tech With Talal on 4/6/25.
//

import SwiftUI
import Charts

struct ProgressView: View {
    @ObservedObject var viewModel: ToDoListViewModel
    @ObservedObject var habitsViewModel: HabitsViewModel
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack(spacing: 16) {
                    StatsRectangleView(title: "Today", count: tasksCompletedToday, total: uncompletedTasks, dateRange: todayDate)
                }
                .padding(.horizontal)
                
                HStack(spacing: 16) {
                    StatsRectangleView(title: "This Week", count: tasksCompletedThisWeek, total: uncompletedTasks, dateRange: weekRange)
                }
                .padding(.horizontal)
                
                if !habitsViewModel.habits.isEmpty {
                    Chart {
                        ForEach(habitsViewModel.habits) { habit in
                            let streak = daysSince(habit.dateStarted)
                            BarMark(
                                x: .value("Habit", habit.title),
                                y: .value("Days", streak)
                            )
                            .foregroundStyle(habitsViewModel.backgroundColor(for: streak))
                        }
                    }
                    .frame(height: 250)
                    .padding()
                    
                } else {
                    EmptyStateView(message: "No habits created")
                }
            }
            .navigationBarTitle("Progress", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    isDarkMode.toggle()
                }) {
                    Image(systemName: isDarkMode ? "circle.lefthalf.filled" : "circle.lefthalf.filled.inverse")
                        .foregroundStyle(isDarkMode ? .white : .black)
                }
            )
        }
    }
    
    var tasksCompletedToday: Int {
        viewModel.tasks.filter {
            $0.isCompleted && Calendar.current.isDateInToday($0.dateCompleted ?? .distantPast)
        }.count
    }
    
    var tasksCompletedThisWeek: Int {
        viewModel.tasks.filter {
            $0.isCompleted &&
            Calendar.current.isDate($0.dateCompleted ?? .distantPast, equalTo: Date(), toGranularity: .weekOfYear)
        }.count
    }
    
    var uncompletedTasks: Int {
        viewModel.tasks.filter {
            !$0.isCompleted
        }.count
    }
    
    var todayDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: Date())
    }
    
    var weekRange: String {
        let calendar = Calendar.current
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        return "\(dateFormatter.string(from: startOfWeek)) - \(dateFormatter.string(from: endOfWeek))"
    }
    
    func daysSince(_ date: Date) -> Int {
        Calendar.current.dateComponents([.day], from: date, to: Date()).day ?? 0
    }
}
