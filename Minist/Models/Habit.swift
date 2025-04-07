//
//  Task.swift
//  Minist
//
//  Created by Talal El Zeini on 9/1/24.
//

import Foundation

struct Habit: Hashable, Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var title: String
    var dateStarted: Date
    
    init(title: String, dateStarted: Date) {
        self.title = title
        self.dateStarted = dateStarted
    }
}
