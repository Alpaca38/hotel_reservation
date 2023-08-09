//
//  Formatter.swift
//  hotel_reservation
//
//  Created by 조규연 on 2023/08/08.
//

import Foundation

class Formatter {
    let dateFormatter = DateFormatter()
    let numberFormatter = NumberFormatter()
    
    init() {
        self.dateFormatter.locale = Locale(identifier:"ko_KR")
        self.dateFormatter.dateFormat = "yyyy-MM-dd"
        self.numberFormatter.numberStyle = .decimal
    }
}
