//
//  TasksViewModel.swift
//  Minist
//
//  Created by Talal El Zeini on 9/1/24.
//

import SwiftUI

class ToDoListViewModel: ObservableObject {
    
    @Published var tasks: [Task] = []
    
    @Published var newTaskTitle: String = ""
    private let userDefaults = UserDefaults.standard
    private let tasksKey: String
    
    @Published var showMaxPinsAlert: Bool = false
    
    init(tasksKey: String) {
        self.tasksKey = tasksKey
        loadTasks()
    }
    
    func completeTask(at index: Int) {
        var task = tasks[index]
        task.isCompleted.toggle()
        
        if task.isCompleted {
            task.dateCompleted = Date()
        } else {
            task.dateCompleted = nil
        }
        
        tasks[index] = task
        saveTasks()
    }
    
    func addTask(isCompleted: Bool) {
        guard !newTaskTitle.isEmpty else { return }
        let newTask = Task(title: newTaskTitle, dateCreated: Date.now, isCompleted: isCompleted, dateCompleted: nil, isPinned: false)
        tasks.append(newTask)
        newTaskTitle = ""
        saveTasks()
    }
    
    func deleteTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: index)
            saveTasks()
        }
    }
    
    
    func pinTask(at index: Int) {
        var task = tasks[index]
        
        // If the task is already pinned, unpin it
        if task.isPinned {
            task.isPinned = false
        } else {
            // Check how many tasks are currently pinned
            let pinnedTasksCount = tasks.filter { $0.isPinned }.count
            
            // Only allow pinning if there are less than 3 pinned tasks
            if pinnedTasksCount < 3 {
                task.isPinned = true
            } else {
                // Show alert if there are already 3 pinned tasks
                showMaxPinsAlert = true
                return
            }
        }
        
        tasks[index] = task
        saveTasks()
    }
    
    
    
    func saveTasks() {
        do {
            let data = try JSONEncoder().encode(tasks)
            userDefaults.set(data, forKey: tasksKey)
        } catch {
            print("Failed to save tasks: \(error)")
        }
    }
    
    func loadTasks() {
        if let data = userDefaults.data(forKey: tasksKey) {
            do {
                tasks = try JSONDecoder().decode([Task].self, from: data)
            } catch {
                print("Failed to load tasks: \(error)")
            }
        }
    }
}
