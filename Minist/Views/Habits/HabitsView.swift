//
// HabitsView.swift
// Minist
//
// Created by Tech With Talal on 4/6/25.
//

import SwiftUI

struct HabitsView: View {
    
    @ObservedObject var habitsViewModel: HabitsViewModel
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State private var showHabitLimitAlert = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if habitsViewModel.habits.isEmpty {
                    EmptyStateView(message: "No habits created")
                } else {
                    HabitsListView(habits: habitsViewModel.habits, habitsViewModel: habitsViewModel)
                }
                
                InputView(
                    addTaskAction: {
                        if habitsViewModel.habits.count >= 5 {
                            showHabitLimitAlert = true
                        } else {
                            habitsViewModel.addHabit()
                        }
                    },
                    newTaskTitle: $habitsViewModel.newHabitTitle,
                    isDarkMode: isDarkMode
                )
            }
            .navigationBarTitle("Habits", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    isDarkMode.toggle()
                }) {
                    Image(systemName: isDarkMode ? "circle.lefthalf.filled" : "circle.lefthalf.filled.inverse")
                        .foregroundStyle(isDarkMode ? .white : .black)
                }
            )
            .alert(isPresented: $showHabitLimitAlert) {
                Alert(
                    title: Text("Limit Reached"),
                    message: Text("You can only create up to 5 habits."),
                    dismissButton: .default(Text("OK"))
                )
            }
            
        }
    }
}
