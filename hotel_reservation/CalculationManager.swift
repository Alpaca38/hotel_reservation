//
//  CalculationManager.swift
//  hotel_reservation
//
//  Created by 조규연 on 2023/08/08.
//

import Foundation

class CalculationManager {
    let formatter = Formatter()

    func calculateFee(roomNumber: Int, checkInDate: Date?, checkOutDate: Date?) -> Int {
        var feePerDay = 0
        
        switch roomNumber {
        case 1:
            feePerDay = 10000
        case 2:
            feePerDay = 20000
        case 3:
            feePerDay = 30000
        case 4:
            feePerDay = 40000
        case 5:
            feePerDay = 50000
        default:
            feePerDay = 0
        }
        
        let days = checkInDate!.distance(to: checkOutDate!) / 86400 //24시간 == 86400초
        let totalFee = feePerDay * Int(days)
        
        var isPremiumMemeber: Bool {
            return days >= 10
        }
        
        let discountAmount = applyDiscount(amount: totalFee, isPremiumMember: isPremiumMemeber)
        let discountedTotalFee = totalFee - discountAmount
        
        return discountedTotalFee
    }

    func applyDiscount(amount: Int, isPremiumMember: Bool) -> Int {
        if isPremiumMember {
            return amount / 5 // 20% 할인
        } else {
            return 0
        }
    }
    
    func printBalance() {
        formatter.numberFormatter.numberStyle = .decimal
        print("잔액은 " + formatter.numberFormatter.string(from: NSNumber(value: balance))! + "원입니다.")
    }

}
