//
//  main.swift
//  hotel_reservation
//
//  Created by 조규연 on 2023/07/20.
//

import Foundation


var balance = 0

let reservationManager = ReservationManager()
let transactionManager = TransactionManager()
let calculationManager = CalculationManager()
let random = Random()
let room = Room()
let menu = Menu()
let user = User()
let formatter = Formatter()

func showMenu() {
    while true {
        let input = menu.selectMenu()
        
        switch input {
        case 1:
            let randomMoney = random.getRandom()
            balance += randomMoney
            if let balance = formatter.numberFormatter.string(from: NSNumber(value: balance)) {
                print("랜덤 금액지급: " + balance + "원")
            }
            transactionManager.getMoney(type: "랜덤 금액으로 입금됨", amount: randomMoney)
        case 2:
            room.printRoomInfo()
        case 3:
            reservationManager.makeReservation()
        case 4:
            reservationManager.printReservationList()
        case 5:
            reservationManager.sortReservation()
        case 6:
            reservationManager.deleteReservation()
        case 7:
            reservationManager.changeRoom()
        case 8:
            transactionManager.printAccountHistory()
        case 9:
            calculationManager.printBalance()
        case 10:
            user.logout()
        case 0:
            return
        default:
            print("잘못 입력하셨습니다. 다시 입력하세요")
        }
    }
}

showMenu()
