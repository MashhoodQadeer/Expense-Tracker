//
//  Transaction.swift
//  Expense Tracker
//  Created by Mashhood Qadeer on 07/12/2024.
//

import Foundation

struct Transaction: Identifiable, Decodable {
    
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
    
    var signedAmount: Double {
        return (self.type == .debit) ? (self.amount * -1) : self.amount
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case date
        case institution
        case account
        case merchant
        case amount
        case type
        case categoryId = "category_id"
        case category
        case isPending = "is_pending"
        case isTransfer = "is_transfer"
        case isExpense = "is_expense"
        case isEdited = "is_edited"
    }
    
    init(id: Int, date: String, institution: String, account: String, merchant: String, amount: Double, type: TransactionType, categoryId: Int, category: String, isPending: Bool, isTransfer: Bool, isExpense: Bool, isEdited: Bool){
        
        self.id = id
        self.date = date
        self.institution = institution
        self.account = account
        self.merchant = merchant
        self.amount = amount
        self.category = category
        self.isPending = isPending
        self.isTransfer = isTransfer
        self.isExpense = isExpense
        self.isEdited = isEdited
        self.type = type
        self.categoryId = categoryId
        
    }
    
    //Decoder Stuff
    init(from decoder: Decoder) {
        let container: KeyedDecodingContainer<CodingKeys>
        do {
            container = try decoder.container(keyedBy: CodingKeys.self)
        } catch {
            id = 0
            date = "Unknown Date"
            institution = "Unknown Institution"
            account = "Unknown Account"
            merchant = "Unknown Merchant"
            amount = 0.0
            type = .debit
            categoryId = 0
            category = "Unknown Category"
            isPending = false
            isTransfer = false
            isExpense = false
            isEdited = false
            return
        }
        
        id = (try? container.decodeIfPresent(Int.self, forKey: .id)) ?? 0
        date = (try? container.decodeIfPresent(String.self, forKey: .date)) ?? "Unknown Date"
        institution = (try? container.decodeIfPresent(String.self, forKey: .institution)) ?? "Unknown Institution"
        account = (try? container.decodeIfPresent(String.self, forKey: .account)) ?? "Unknown Account"
        merchant = (try? container.decodeIfPresent(String.self, forKey: .merchant)) ?? "Unknown Merchant"
        amount = (try? container.decodeIfPresent(Double.self, forKey: .amount)) ?? 0.0
        let typeStr = (try? container.decodeIfPresent(String.self, forKey: .type)) ?? "debit"
        type = typeStr.elementsEqual(TransactionType.debit.rawValue) ? TransactionType.debit : TransactionType.credit
        categoryId = (try? container.decodeIfPresent(Int.self, forKey: .categoryId)) ?? 0
        category = (try? container.decodeIfPresent(String.self, forKey: .category)) ?? "Unknown Category"
        isPending = (try? container.decodeIfPresent(Bool.self, forKey: .isPending)) ?? false
        isTransfer = (try? container.decodeIfPresent(Bool.self, forKey: .isTransfer)) ?? false
        isExpense = (try? container.decodeIfPresent(Bool.self, forKey: .isExpense)) ?? false
        isEdited = (try? container.decodeIfPresent(Bool.self, forKey: .isEdited)) ?? false
    }

}

enum TransactionType: String {
     case debit = "debit"
     case credit = "credit"
}

