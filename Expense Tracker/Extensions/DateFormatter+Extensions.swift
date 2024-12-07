//  DateFormatter+Extensions.swift
//  Expense Tracker
//  Created by Mashhood Qadeer on 07/12/2024.

import Foundation

extension Date {
    
    var americanStringValue: String {
        
        var dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        return dateFormatter.string(from: self)
        
    }
    
}

extension String {
    
    var americanDateValue: Date {
        
        var dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        return dateFormatter.date(from: self) ?? Date()
        
    }
    
}
