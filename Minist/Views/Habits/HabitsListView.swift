//
// HabitsListView.swift
// Minist
//
// Created by Tech With Talal on 4/6/25.
//

import SwiftUI

struct HabitsListView: View {
    let habits: [Habit]
    @ObservedObject var habitsViewModel: HabitsViewModel
    
    var body: some View {
        List {
            ForEach(habits.reversed()) { habit in
                HabitRowView(habit: habit, habitsViewModel: habitsViewModel)
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            habitsViewModel.deleteHabit(habit)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
            }
        }
        .listRowSpacing(20)
    }
}
