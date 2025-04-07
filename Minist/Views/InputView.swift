//
//  InputView.swift
//  Minist
//
//  Created by Talal El Zeini on 9/1/24.
//

import SwiftUI

struct InputView: View {
    let addTaskAction: () -> Void
    
    private let suggestionsList = [
        "Buy groceries", "Finish homework", "Call mom", "Clean the house", "Pay bills",
        "Read a book", "Exercise", "Walk the dog", "Cook dinner", "Check email",
        "Go for a run", "Do laundry", "Organize closet", "Schedule a doctor's appointment",
        "Update resume", "Water the plants", "Take out the trash"
    ]
    
    @Binding var newTaskTitle: String
    @State var scrollToTop: Bool = false
    @FocusState private var textFieldIsFocused: Bool
    var isDarkMode: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            TextField(suggestionsList.randomElement() ?? "Add a new task here", text: $newTaskTitle)
                .padding()
                .frame(width: UIScreen.main.bounds.width - 50, height: 50)
                .focused($textFieldIsFocused)
                .submitLabel(.done)
            
            Button(action: {
                addTaskAction()
                scrollToTop = true
            }) {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(isDarkMode ? .white : .black)
                    .padding()
                    .font(.system(size: 25))
            }
            .frame(height: 50)
        }
        .background(isDarkMode ? .black : Color(.systemGray6))
    }
}
