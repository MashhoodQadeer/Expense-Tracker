//
//  TransactionRow.swift
//  Expense Tracker
//
//  Created by Mashhood Qadeer on 07/12/2024.
//

import Foundation
import SwiftUI
import SwiftUIFontIcon

struct TransactionRow: View {
    
    var transaction: Transaction
    
    var body: some View {
        
        HStack(spacing: 20){
            
            //MARK: Transaction Category Icon
            RoundedRectangle(cornerRadius: 20,
                 style: .continuous)
            .fill(Color.icon.opacity(0.3))
            .frame(width: 44, height: 44)
            .overlay {
                FontIcon.text( .awesome5Solid(code: self.transaction.categoryIcon),
                               fontsize:24, color: Color.icon
                )
            }
            
            VStack( alignment: .leading, spacing: 2 ){
                    
                //MARK: Transaction Merchant
                Text(transaction.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                 
                //MARK: Transaction Category
                Text(transaction.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                
                //MARK: Transaction Date
                Text(transaction.date.americanDateValue.americanStringValue)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                
            }
            
            //Spacer
            Spacer()
            
            //Amount
            Text( transaction.signedAmount,
                  format: .currency(code: "USD") )
                 .bold()
                 .foregroundColor( (transaction.type == .debit) ? Color.red : Color.secondary)
            
        }.padding( 8 )
    }
    
}

struct TransactionRow_Previews: PreviewProvider {
    
    static var previews: some View {
            
           Group {
               
               TransactionRow(transaction: transactionPreview)
               
               TransactionRow(transaction:      transactionPreview).colorScheme(.dark)
               
           }
           
    }
    
}
