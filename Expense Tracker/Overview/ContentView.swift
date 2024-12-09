//  ContentView.swift
//  Expense Tracker
//  Created by Mashhood Qadeer on 07/12/2024.

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: ContentViewModel = ContentViewModel()
    
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
                
                //Transactions List
                VStack{
                    RecentTransactionList( isLoading: $viewModel.loading, transactionsList: $viewModel.transactionsList)
                        .onAppear(){
                            self.viewModel.loadTransactions()
                        }
                }.padding()
                
                
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

