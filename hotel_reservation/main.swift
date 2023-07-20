//
//  main.swift
//  hotel_reservation
//
//  Created by 조규연 on 2023/07/20.
//

import Foundation

var menu = ["1. 랜덤금액 지급", "2. 호텔 방 정보", "3. 호텔 객실 예약", "4. 나의 예약 목록 보기", "5. 나의 예약 목록 체크인 날짜 순으로 보기", "0. 종료"]
var balance = 0
var rooms = [
    (number:1, price: 10000),
    (number:2, price: 20000),
    (number:3, price: 30000),
    (number:4, price: 40000),
    (number:5, price: 50000)
]

var reservations: [Reservation] = []

struct Reservation {
    let roomNumber: Int
    let checkInDate: Date
    let checkOutDate: Date
    let reservationFee: Int
}

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
    for room in rooms {
        print("\(room.number)번방 1박 \(room.price)원")
    }
}

func selectMenu() -> Int {
    print("호텔 예약 서비스")
    printMenu()
    let input = Int(readLine()!)!
    
    return input
}

let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd"
dateFormatter.locale = Locale(identifier:"ko_KR")

func makeReservation() {
    print("호텔 방 예약을 받습니다.")
    print("호텔 방 번호를 입력하세요:")
    let roomNumber = Int(readLine()!)!
    
    print("체크인 날짜를 입력하세요 (yyyy-MM-dd):")
    let checkInDateString = readLine()!
    let checkInDate = dateFormatter.date(from: checkInDateString)!
    
    print("체크아웃 날짜를 입력하세요 (yyyy-MM-dd):")
    let checkOutDateString = readLine()!
    let checkOutDate = dateFormatter.date(from: checkOutDateString)!
    
    if isReservationAvailable(roomNumber: roomNumber, checkInDate: checkInDate, checkOutDate: checkOutDate) {
        let reservationFee = calculateFee(roomNumber: roomNumber, checkInDate: checkInDate, checkOutDate: checkOutDate)
        balance -= reservationFee
        
        if balance < 0 {
            print("잔액이 부족합니다.")
            balance += reservationFee
        } else {
            print("예약이 완료되었습니다.")
            reservations.append(Reservation(roomNumber: roomNumber, checkInDate: checkInDate, checkOutDate: checkOutDate, reservationFee: reservationFee))
        }
    }
    else {
        print("호텔 방이 예약 불가능합니다.")
    }
}

func calculateFee(roomNumber: Int, checkInDate: Date, checkOutDate: Date) -> Int {
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
    
    let days = checkInDate.distance(to: checkOutDate) / 86400 //24시간 == 86400초
    
    return feePerDay * Int(days)
}

func isReservationAvailable(roomNumber: Int, checkInDate: Date, checkOutDate: Date) -> Bool {
    let isAvailable = reservations.filter { $0.roomNumber == roomNumber && $0.checkInDate <= checkInDate && $0.checkOutDate >= checkOutDate }.isEmpty

    return isAvailable
}

func printReservationList() {
    for reservation in reservations {
        print("방 번호: \(reservation.roomNumber)")
        print("체크인 날짜: \(dateFormatter.string(from: reservation.checkInDate))")
        print("체크아웃 날짜: \(dateFormatter.string(from: reservation.checkOutDate))")
        print("예약 금액: \(reservation.reservationFee)")
    }
}

func sortReservation() {
    reservations.sort { $0.checkInDate < $1.checkInDate }
    printReservationList()
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
            makeReservation()
        case 4:
            printReservationList()
        case 5:
            sortReservation()
        case 0:
            return
        default:
            print("잘못 입력하셨습니다. 다시 입력하세요")
        }
    }
}

main()
