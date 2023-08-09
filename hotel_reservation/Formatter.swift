//
//  Formatter.swift
//  hotel_reservation
//
//  Created by 조규연 on 2023/08/08.
//

import Foundation

class Formatter {
    let numberFormatter = NumberFormatter()
    let dateFormatter = DateFormatter()
    
    init() {
        self.dateFormatter.locale = Locale(identifier:"ko_KR")
        self.dateFormatter.dateFormat = "yyyy-MM-dd"
    }
}
