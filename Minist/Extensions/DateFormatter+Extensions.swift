//
//  DateFormatter+Extensions.swift
//  Minist
//
//  Created by Talal El Zeini on 9/1/24.
//

import Foundation

extension DateFormatter {
    static let customDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
}

