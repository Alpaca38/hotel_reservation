//
//  Room.swift
//  hotel_reservation
//
//  Created by 조규연 on 2023/08/08.
//

import Foundation

class Room {
    let rooms = [
        (number:1, price: 10000),
        (number:2, price: 20000),
        (number:3, price: 30000),
        (number:4, price: 40000),
        (number:5, price: 50000)
    ]
    
    func printRoomInfo() {
        for room in rooms {
            print("\(room.number)번방 1박 \(room.price)원")
        }
    }
}
