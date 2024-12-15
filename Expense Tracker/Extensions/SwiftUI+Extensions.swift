//
//  SwiftUI+Extensions.swift
//  Expense Tracker
//
//  Created by Mashhood Qadeer on 14/12/2024.
//

import SwiftUI

struct BeautifyModifier: ViewModifier {
    
    let cornerRadius: Double
    let shadowColor: Color
    let shadowRadius: Double
    
    func body(content: Content) -> some View {
             content
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(self.cornerRadius)
            .shadow(color: self.shadowColor, radius: self.shadowRadius)
    }
    
}

extension View {
    func beautify(
         cornerRadius: Double = 20,
         shadowColor: Color = Color.black.opacity(0.15),
         shadowRadius: Double = 10
    ) -> some View {
        self.modifier(BeautifyModifier(
             cornerRadius: cornerRadius,
             shadowColor: shadowColor,
             shadowRadius: shadowRadius))
    }
}

