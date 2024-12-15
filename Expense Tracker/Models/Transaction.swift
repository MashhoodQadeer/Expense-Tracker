//  Transaction.swift
// Expense Tracker
// Created by Mashhood Qadeer on 07/12/2024.

import Foundation
import SwiftUIFontIcon
import OrderedCollections

struct Transaction: Hashable, Identifiable, Decodable {
    
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
    
    var categoryIcon: FontAwesomeCode {
        get {
            return Category.allCategories.filter({$0.name.elementsEqual(self.category)}).first?.icon ?? FontAwesomeCode.question
        }
    }
    
}

enum TransactionType: String {
     case debit = "debit"
     case credit = "credit"
}

struct Category {
    let id: Int
    let name: String
    let icon: FontAwesomeCode
    var mainCategoryId: Int?
}

extension Category {
    
    //Without Main Category
    static let autoAndTransport = Category(id: 1, name: "Auto & Transport", icon: .car_alt)
    static let bilsAndUtilities = Category(id: 2, name: "Bills & Utilities", icon: .file_invoice_dollar)
    static let entertainment = Category(id: 3, name: "Entertainment", icon: .film)
    static let feesAndCharges = Category(id: 4, name: "Fees & Charges", icon: .hand_holding_usd)
    static let foodAndDining = Category(id: 5, name: "Food & Dining", icon: .hamburger)
    static let home = Category(id: 6, name: "Home", icon: .home)
    static let income = Category(id: 7, name: "Income", icon: .dollar_sign)
    static let shopping = Category(id: 8, name: "Shopping", icon: .shopping_cart)
    static let transfer = Category(id: 9, name: "Transfer", icon: .exchange_alt)
    
    //With Category
    static let publicTransportation = Category(id: 101, name: "Public Transportation", icon: .bus, mainCategoryId: 1)
    static let taxi = Category(id: 102, name: "Taxi", icon: .taxi, mainCategoryId: 1)
    static let mobilePhone = Category(id: 201, name: "Mobile Phone", icon: .mobile_alt, mainCategoryId: 2)
    static let moviesAndDVDs = Category(id: 301, name: "Movies & DVDs", icon: .film, mainCategoryId: 3)
    static let bankFee = Category(id: 401, name: "Bank Fee", icon: .hand_holding_usd, mainCategoryId: 4)
    static let financeCharge = Category(id: 402, name: "Finance Charge", icon: .hand_holding_usd, mainCategoryId: 4)
    static let groceries = Category(id: 501, name: "Groceries", icon: .shopping_basket, mainCategoryId: 5)
    static let resturants = Category(id: 502, name: "Resturants", icon: .utensils, mainCategoryId: 5)
    static let rent = Category(id: 601, name: "Rent", icon: .house_user, mainCategoryId: 6)
    static let homeSupplies = Category(id: 602, name: "Home Supplies", icon: .lightbulb, mainCategoryId: 6)
    static let paycheque = Category(id: 701, name: "Paycheque", icon: .dollar_sign, mainCategoryId: 7)
    static let software = Category(id: 801, name: "Software", icon: .icons, mainCategoryId: 8)
    static let creditCardPayment = Category(id: 901, name: "Credit Card Payment", icon: .exchange_alt, mainCategoryId: 9)
    
}

//For Categories
extension Category {
    
    //For Main Category
    static let categories: [Category] = [
        Category.autoAndTransport,
        Category.bilsAndUtilities,
        Category.entertainment,
        Category.feesAndCharges,
        Category.foodAndDining,
        Category.home,
        Category.income,
        Category.shopping,
        Category.transfer
    ]
    
    //For Subcategories
    static var subcategories: [Category] = [
           Category.publicTransportation,
           Category.taxi,
           Category.mobilePhone,
           Category.moviesAndDVDs,
           Category.bankFee,
           Category.financeCharge,
           Category.groceries,
           Category.resturants,
           Category.rent,
           Category.homeSupplies,
           Category.paycheque,
           Category.software,
           Category.creditCardPayment
    ]
    
    static var allCategories: [Category] {
           let combinedArray = categories + subcategories
           return combinedArray
    }
    
}

extension Transaction {
    
    static func getOrderedTransactions(transactions: [Transaction]) -> OrderedDictionary<String, [Transaction]> {
        
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "MMMM yyyy"
         var orderedDictionary = OrderedDictionary<String, [Transaction]>()

         for transaction in transactions {
             
             let dateKey = dateFormatter.string(
                                        from: transaction.date.americanDateValue
                                               )
             if orderedDictionary[dateKey] != nil {
                orderedDictionary[dateKey]?.append(transaction)
             } else {
                orderedDictionary[dateKey] = [transaction]
             }
             
         }

         return orderedDictionary
        
    }

    static func getOrderedTransactionSum(transactions: [Transaction]) -> OrderedDictionary<String, Double> {
        
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "dd MMMM yyyy"
         var orderedDictionary = OrderedDictionary<String, Double>()

         for transaction in transactions {
             
             let dateKey = dateFormatter.string(
                                        from: transaction.date.americanDateValue
                                               )
             if orderedDictionary[dateKey] != nil {
                 orderedDictionary[dateKey] = transaction.amount + (orderedDictionary[dateKey] ?? 0)
             } else {
                 orderedDictionary[dateKey] = transaction.amount
             }
             
         }

         return orderedDictionary
        
    }
    
}
