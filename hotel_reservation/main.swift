//
//  main.swift
//  hotel_reservation
//
//  Created by 조규연 on 2023/07/20.
//

import Foundation

var menu = ["1. 랜덤금액 지급", "2. 호텔 방 정보", "3. 종료"]
var balance = 0

func printMenu() {
    for i in 0..<menu.count {
        print(menu[i])
    }
}

func getRandom() -> Int {
    let randomMoney = (Int.random(in: 100000...500000) / 10000) * 10000
    return randomMoney
}

func printRoomInfo() {
    print("1번방 1박 10000원")
    print("2번방 1박 20000원")
    print("3번방 1박 30000원")
    print("4번방 1박 40000원")
    print("5번방 1박 50000원")
}

func selectMenu() -> Int {
    print("호텔 예약 서비스")
    printMenu()
    let input = Int(readLine()!)!
    
    return input
}

func main() {
    while true {
        let input = selectMenu()
        
        switch input {
        case 1:
            balance += getRandom()
            print("랜덤 금액지급: \(balance)")
        case 2:
            printRoomInfo()
        case 3:
            break
        default:
            print("잘못 입력하셨습니다. 다시 입력하세요")
        }
    }
}

main()
