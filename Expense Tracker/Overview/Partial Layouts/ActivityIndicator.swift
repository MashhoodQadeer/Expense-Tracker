//  ActivityIndicator.swift
//  Expense Tracker
//  Created by Mashhood Qadeer on 10/12/2024.

import SwiftUI
import UIKit

struct LoadingIndicator: UIViewRepresentable {
    
    @Binding var isLoading: Bool
    

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        
         let activityIndicator = UIActivityIndicatorView(style: .large)
         activityIndicator.hidesWhenStopped = true
         return activityIndicator
        
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
         if isLoading {
            uiView.startAnimating()
         } else {
            uiView.stopAnimating()
         }
        
    }
    
}
