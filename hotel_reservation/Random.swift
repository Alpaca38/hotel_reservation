//
//  Random.swift
//  hotel_reservation
//
//  Created by 조규연 on 2023/08/08.
//

import Foundation

class Random {
    let formatter = Formatter()
    
    func getRandom() -> Int {
        let randomMoney = (Int.random(in: 100000...500000) / 10000) * 10000
        
        return randomMoney
    }
}
