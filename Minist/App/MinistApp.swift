//
//  ContentView.swift
//  Minist
//
//  Created by Talal El Zeini on 9/1/24.
//

import SwiftUI

@main
struct MinistApp: App {

    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @StateObject var viewModel = ToDoListViewModel(tasksKey: "tasksKey")
    @StateObject var habitsViewModel = HabitsViewModel(habitsKey: "habitsKey")

    var body: some Scene {
        WindowGroup {
            TabView{
                ToDoListView(viewModel: viewModel)
                    .tabItem {
                        Label("Tasks", systemImage:"checklist")
                    }

                HabitsView(habitsViewModel: habitsViewModel)
                    .tabItem {
                        Label("Habits", systemImage: "repeat.circle.fill")
                    }

                ProgressView(viewModel: viewModel, habitsViewModel: habitsViewModel)
                    .tabItem {
                        Label("Progress", systemImage: "chart.bar.fill")
                    }
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
