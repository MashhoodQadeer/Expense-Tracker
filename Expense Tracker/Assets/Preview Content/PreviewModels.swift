//  PreviewModels.swift
//  Expense Tracker
//  Created by Mashhood Qadeer on 07/12/2024.

var transactionPreview = Transaction(id: 1, date: "01/24/2022", institution: "Desjardin", account:"Visa Desjardins", merchant: "Apple", amount: 11.49, type: .credit, categoryId: 801, category: "Software", isPending: false, isTransfer: false, isExpense: true, isEdited: false)

var transactionListPreviewData = [Transaction](repeating: transactionPreview, count: 10)
