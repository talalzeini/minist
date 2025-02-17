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
    
    var body: some Scene {
        WindowGroup {
            ToDoListView(viewModel: viewModel)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
