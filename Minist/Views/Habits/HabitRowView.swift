//
// HabitRowView.swift
// Minist
//
// Created by Tech With Talal on 4/6/25.
//

import SwiftUI

struct HabitRowView: View {
    let habit: Habit
    @ObservedObject var habitsViewModel: HabitsViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(habit.title)
                    .font(.headline)
                Text("Started on \(DateFormatter.customDateFormatter.string(from: habit.dateStarted))")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            
            Text("\(daysSinceStarted()) day\(daysSinceStarted() == 1 ? "" : "s")")
                .font(.headline)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(habitsViewModel.backgroundColor(for: daysSinceStarted()))
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .contentShape(Rectangle())
        .padding(.vertical, 8)
    }
    
    private func daysSinceStarted() -> Int {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: habit.dateStarted)
        let today = calendar.startOfDay(for: Date())
        let components = calendar.dateComponents([.day], from: startOfDay, to: today)
        return components.day ?? 0
    }
}
