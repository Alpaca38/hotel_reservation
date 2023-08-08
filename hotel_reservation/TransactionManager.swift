//
//  TransactionManager.swift
//  hotel_reservation
//
//  Created by 조규연 on 2023/08/08.
//

import Foundation

class TransactionManager {
    var transactions: [Transaction] = []
    let formatter = Formatter()
    
    func printAccountHistory() {
        for transaction in transactions {
            print(transaction.type, formatter.numberFormatter.string(from: NSNumber(value: transaction.amount))! + "원")
        }
    }
    
    func getMoney(type: String, amount: Int) {
        transactions.append(Transaction(type: type, amount: amount))
    }
}
struct Transaction {
    var type: String
    var amount: Int
}

