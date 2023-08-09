//
//  ReservationManager.swift
//  hotel_reservation
//
//  Created by 조규연 on 2023/08/08.
//

import Foundation

class ReservationManager {
    var reservations: [Reservation] = []
    let transactionManager = TransactionManager()
    let formatter = Formatter()
    let calculationManager = CalculationManager()
    let room = Room()
    
    func makeReservation() {
        print("호텔 방 예약을 받습니다.")
        print("호텔 방 번호를 입력하세요:")
        let roomNumber = Int(readLine()!)!
        
        print("체크인 날짜를 입력하세요 (yyyy-MM-dd):")
        let checkInDateString = readLine()!
        let checkInDate = formatter.dateFormatter.date(from: checkInDateString)!
        
        print("체크아웃 날짜를 입력하세요 (yyyy-MM-dd):")
        let checkOutDateString = readLine()!
        let checkOutDate = formatter.dateFormatter.date(from: checkOutDateString)!
        
        let reservationFee = calculationManager.calculateFee(roomNumber: roomNumber, checkInDate: checkInDate, checkOutDate: checkOutDate)
        
        if isReservationAvailable(roomNumber: roomNumber, checkInDate: checkInDate, checkOutDate: checkOutDate) {
            
            balance -= reservationFee
            
            if balance < 0 {
                print("잔액이 부족합니다.")
                balance += reservationFee
            } else {
                print("예약이 완료되었습니다.")
                reservations.append(Reservation(roomNumber: roomNumber, checkInDate: checkInDate, checkOutDate: checkOutDate, reservationFee: reservationFee))
                transactionManager.getMoney(type: "예약으로 입금됨", amount: reservationFee)
            }
        }
        else {
            print("호텔 방이 예약 불가능합니다.")
        }
    }
    
    func isReservationAvailable(roomNumber: Int, checkInDate: Date, checkOutDate: Date) -> Bool {
        let isAvailable = reservations.filter { $0.roomNumber == roomNumber && $0.checkInDate <= checkInDate && $0.checkOutDate >= checkOutDate }.isEmpty

        return isAvailable
    }

    func printReservationList() {
        for reservation in reservations {
            print("방 번호: \(reservation.roomNumber)")
            print("체크인 날짜: \(formatter.dateFormatter.string(from: reservation.checkInDate))")
            print("체크아웃 날짜: \(formatter.dateFormatter.string(from: reservation.checkOutDate))")
            print("예약 금액: \(reservation.reservationFee)")
        }
    }

    func sortReservation() {
        reservations.sort { $0.checkInDate < $1.checkInDate }
        printReservationList()
    }

    func deleteReservation() {
        
        printReservationList()
        print("취소할 예약 번호를 입력하세요.")
        let deleteReservNum = Int(readLine()!)!
        
        let currentDate = Date()
        let dateDifference = currentDate.distance(to: reservations[deleteReservNum-1].checkInDate) / 86400 // 하루 86400초
        
        if dateDifference >= 30 {
            balance += reservations[deleteReservNum-1].reservationFee
            transactionManager.getMoney(type: "환불금으로 입금됨", amount: reservations[deleteReservNum-1].reservationFee)
            reservations.remove(at: deleteReservNum-1)
            print("예약을 취소하였습니다.")
        } else if dateDifference >= 14 {
            balance += reservations[deleteReservNum-1].reservationFee / 2
            transactionManager.getMoney(type: "환불금으로 입금됨", amount: reservations[deleteReservNum-1].reservationFee / 2)
            reservations.remove(at: deleteReservNum-1)
            print("예약을 취소하였습니다.")
        } else if dateDifference >= 7 {
            balance += reservations[deleteReservNum-1].reservationFee / 4
            transactionManager.getMoney(type: "환불금으로 입금됨", amount: reservations[deleteReservNum-1].reservationFee / 4)
            reservations.remove(at: deleteReservNum-1)
            print("예약을 취소하였습니다.")
        } else {
            print("환불이 불가합니다.")
        }
    }

    func changeRoom() {
        printReservationList()
        print("변경할 예약 번호를 입력하세요.")
        let changeReservNum = Int(readLine()!)!
        
        room.printRoomInfo()
        print("변경할 방 번호를 입력하세요.")
        let changeRoomNum = Int(readLine()!)!
        
        let oldFee = reservations[changeReservNum-1].reservationFee
        reservations[changeReservNum-1].roomNumber = changeRoomNum
        let calculateFee = calculationManager.calculateFee(roomNumber: reservations[changeReservNum-1].roomNumber, checkInDate: reservations[changeReservNum-1].checkInDate, checkOutDate: reservations[changeReservNum-1].checkOutDate)
        let newFee = calculateFee
        
        let feeDifference = oldFee - newFee
        
        if oldFee > newFee {
            balance += feeDifference
            transactionManager.getMoney(type: "차액만큼 입금됨", amount: feeDifference)
        } else {
            balance += feeDifference
            transactionManager.getMoney(type: "차액만큼 출금됨", amount: -(feeDifference))
        }
    }
}

struct Reservation {
    var roomNumber: Int
    let checkInDate: Date
    let checkOutDate: Date
    let reservationFee: Int
}
