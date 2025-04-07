//
//  HabitsViewModel.swift
//  Minist
//
//  Created by Talal El Zeini on 9/1/24.
//

import SwiftUI

class HabitsViewModel: ObservableObject {
    
    @Published var habits: [Habit] = []
    
    @Published var newHabitTitle: String = ""
    private let userDefaults = UserDefaults.standard
    private let habitsKey: String
    
    init(habitsKey: String) {
        self.habitsKey = habitsKey
        loadHabits()
        
    }
    
    func addHabit() {
        guard !newHabitTitle.isEmpty else { return }
        let newHabit = Habit(title: newHabitTitle, dateStarted: Date.now)
        habits.append(newHabit)
        newHabitTitle = ""
        saveHabits()
    }
    
    func deleteHabit(_ habit: Habit) {
        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
            habits.remove(at: index)
            saveHabits()
        }
    }
    
    func saveHabits() {
        do {
            let data = try JSONEncoder().encode(habits)
            userDefaults.set(data, forKey: habitsKey)
        } catch {
            print("Failed to save habits: \(error)")
        }
    }
    
    func loadHabits() {
        if let data = userDefaults.data(forKey: habitsKey) {
            do {
                habits = try JSONDecoder().decode([Habit].self, from: data)
            } catch {
                print("Failed to load habits: \(error)")
            }
        }
    }
    
    func backgroundColor(for streak: Int) -> Color {
        switch streak {
        case 0...3:
            return Color.red
        case 4...7:
            return Color.orange
        case 8...14:
            return Color.yellow
        case 15...29:
            return Color.green
        case 30...:
            return Color.green
        default:
            return Color.gray
        }
    }
}
