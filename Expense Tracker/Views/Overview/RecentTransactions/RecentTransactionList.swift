//  RecentTransactionList.swift
//  Expense Tracker
//  Created by Mashhood Qadeer on 10/12/2024.

import SwiftUI
import Collections

struct RecentTransactionList: View {
    
    var transactionsPrefix: Int = 5
    @Binding var isLoading: Bool
    @Binding var transactionsList: [Transaction]
    @State var showTransactionsList: Bool = false
    
    var body: some View {
        
        VStack{
            
            HStack{
                
                //MARK: Header Title
                Text("Recent Transactions")
                    .bold()
                
                Spacer()
                
                HStack(spacing: 4){
                    Text("See All")
                    Image(systemName: "chevron.right")
                }
                .foregroundColor(Color.textColor)
                .onTapGesture {
                    
                    showTransactionsList = true
                    
                }
                
                //Navigation
                NavigationLink( destination:
                                    
                                    TransactionsList(orderedTransaction: .constant(Transaction.getOrderedTransactions(transactions: transactionsList)))
                                    
                                    , isActive: $showTransactionsList) {
                    EmptyView()
                }.opacity(0.0)
                
            }
            
            //Divider
            if !($transactionsList.count == 0) {
                Divider()
            }
            
            //Transactions List
            if self.isLoading {
                VStack{
                    
                    LoadingIndicator(isLoading: $isLoading )
                        .padding(5)
                        .background(
                            Color.backgroundColor.opacity(0.25).clipShape(Circle())
                        )
                    
                }.padding()
                
            } else {
               
                ForEach(Array(self.transactionsList.prefix(transactionsPrefix).enumerated()), id: \.offset) { index, transaction in
                    
                    TransactionRow(transaction: transaction)
                    
                    if index != transactionListPreviewData.prefix(transactionsPrefix).count - 1 {
                            Divider()
                    }
                    
                }
                
            }
        
        }
        .padding()
        .background( Color(.systemBackground) )
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20), style: .continuous))
        .shadow(color: Color.black.opacity(0.15), radius: 10)
        
        }

}

//MARK: - Making Extension To Get Results In Sorted Way


//MARK: - Preview Providers
struct RecentTransactionListPreviews: PreviewProvider {
  
    static var previews: some View {
        
        RecentTransactionList(isLoading: .constant(false), transactionsList: .constant( transactionListPreviewData ) )
            
    }
    
}
