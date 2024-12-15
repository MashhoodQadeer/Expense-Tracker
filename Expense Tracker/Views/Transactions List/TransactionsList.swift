//  TransactionsList.swift
//  Expense Tracker
//  Created by Mashhood Qadeer on 13/12/2024

import SwiftUI
import UIKit
import Collections

struct TransactionsList: View {
    
    @Binding var orderedTransaction: OrderedDictionary<String, [Transaction]>
    
       var body: some View {
           
           VStack {
                 
               List{
                   
                   ForEach( Array(orderedTransaction), id: \.key ) { heading, transactions in
                       
                       Section{
                        
                           ForEach(transactions) { transaction in
                               
                               TransactionRow(transaction: transaction)
                               
                           }
                           
                       }
                       
                       header: {
                           Text(heading.capitalizeFirstLetter())
                       }
                       
                   }.listSectionSeparator(.hidden)
                   
               }.listStyle(.plain)
               
           }.navigationTitle("Transactions")
            .navigationBarTitleDisplayMode(.inline)
           
       }
       
}

struct TransactionsListPreviews: PreviewProvider {
      
       static var previews: some View {
              
           Group {
               
               TransactionsList( orderedTransaction: .constant(Transaction.getOrderedTransactions(transactions: transactionListPreviewData)) )
               
               TransactionsList( orderedTransaction: .constant(Transaction.getOrderedTransactions(transactions: transactionListPreviewData)) ).colorScheme(.dark)
           }
           
       }
    
}

