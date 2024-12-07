//  ContentView.swift
//  Expense Tracker
//  Created by Mashhood Qadeer on 07/12/2024.


import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24){
                    Text("Overview")
                        .font(.title2)
                        .bold()
                }
                .padding(.top)
                .frame(maxWidth: .infinity)
            }
            .background(Color.backgroundColor)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem{
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.icon, .primary)
                }
            }
            
        }.navigationViewStyle(.stack)
        
    }
    
}


struct ContentPreview : PreviewProvider {
    
    static var previews: some View {
        Group{
            ContentView()
            ContentView().colorScheme(.dark)
        }
    }
    
}

