//
//  Task.swift
//  Minist
//
//  Created by Talal El Zeini on 9/1/24.
//

import Foundation

struct Task: Hashable, Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var title: String
    var isCompleted: Bool
    var dateCreated: Date
    var dateCompleted: Date? = nil
    var isPinned: Bool = false
    
    init(title: String, dateCreated: Date, isCompleted: Bool, dateCompleted: Date?, isPinned: Bool) {
        self.title = title
        self.dateCreated = dateCreated
        self.isCompleted = isCompleted
        self.dateCompleted = dateCompleted
        self.isPinned = isPinned
    }
}
