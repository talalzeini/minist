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
    
    init(title: String, dateCreated: Date, isCompleted: Bool) {
        self.title = title
        self.dateCreated = dateCreated
        self.isCompleted = isCompleted
    }
}
