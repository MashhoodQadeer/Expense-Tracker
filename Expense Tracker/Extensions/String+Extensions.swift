//
//  String+Extensions.swift
//  Expense Tracker
//
//  Created by Mashhood Qadeer on 13/12/2024.
//

extension String {
    
        func capitalizeFirstLetter() -> String {
            guard !self.isEmpty else { return self }
            return self.prefix(1).uppercased() + self.dropFirst().lowercased()
        }
    
}
