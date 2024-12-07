//
//  Transaction.swift
//  Expense Tracker
//  Created by Mashhood Qadeer on 07/12/2024.
//

import Foundation

struct Transaction: Identifiable {
    
    let id: Int
    let date: String
    let institution: String
    let account: String
    let merchant: String
    let amount: Double
    let type: TransactionType
    let categoryId: Int
    let category: String
    let isPending: Bool
    let isTransfer: Bool
    let isExpense: Bool
    let isEdited: Bool
    
    var signedAmount: Double{
        return ( self.type == .debit ) ? (self.amount * -1) : self.amount
    }
    
}

enum TransactionType: String {
     case debit = "debit"
     case credit = "credit"
}

