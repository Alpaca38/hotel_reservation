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
    let user = User()
    
    func makeReservation() {
        user.login()
        print("호텔 방 예약을 받습니다.")
        print("호텔 방 번호를 입력하세요:")
        guard let roomNumber = readLine(), let roomNumber = Int(roomNumber) else {
            print("잘못된 입력입니다. 다시 입력해 주세요.")
            return makeReservation()
        }
        
        print("체크인 날짜를 입력하세요 (yyyy-MM-dd):")
        var checkInDate: Date? = nil
        while checkInDate == nil {
            if let checkInDateString = readLine(),
               let date = formatter.dateFormatter.date(from: checkInDateString) {
                checkInDate = date
            } else {
                print("유효한 체크인 날짜를 입력해주세요.")
            }
        }
        
        print("체크아웃 날짜를 입력하세요 (yyyy-MM-dd):")
        var checkOutDate: Date? = nil
        while checkOutDate == nil {
            if let checkOutDateString = readLine(),
               let date = formatter.dateFormatter.date(from: checkOutDateString) {
                checkOutDate = date
            } else {
                print("유효한 체크아웃 날짜를 입력해주세요.")
            }
        }
        
        let reservationFee = calculationManager.calculateFee(roomNumber: roomNumber, checkInDate: checkInDate, checkOutDate: checkOutDate)
        
        if isReservationAvailable(roomNumber: roomNumber, checkInDate: checkInDate, checkOutDate: checkOutDate) {
            
            balance -= reservationFee
            
            if balance < 0 {
                print("잔액이 부족합니다.")
                balance += reservationFee
            } else {
                if let currentUser = user.currentUser {
                    print("예약이 완료되었습니다.")
                    reservations.append(Reservation(userName: currentUser, roomNumber: roomNumber, checkInDate: checkInDate, checkOutDate: checkOutDate, reservationFee: reservationFee))
                    transactionManager.getMoney(type: "예약으로 입금됨", amount: reservationFee)
                } else {
                    print("error")
                }
            }
        }
        else {
            print("호텔 방이 예약 불가능합니다.")
        }
    }
    
    func isReservationAvailable(roomNumber: Int, checkInDate: Date?, checkOutDate: Date?) -> Bool {
        guard let checkInDate = checkInDate, let checkOutDate = checkOutDate else {
            return false
        }
        let isAvailable = reservations.filter { reservation in
            if let reservationCheckIn = reservation.checkInDate, let reservationCheckOut = reservation.checkOutDate {
                return reservation.roomNumber == roomNumber &&
                reservationCheckIn <= checkInDate &&
                reservationCheckOut >= checkOutDate
            }
            return false
        }.isEmpty
        
        return isAvailable
    }
    
    func printReservationList() {
        for reservation in reservations {
            print("사용자: \(reservation.userName)")
            print("방 번호: \(reservation.roomNumber)")
            if let checkInDate = reservation.checkInDate,
               let checkOutDate = reservation.checkOutDate {
                print("체크인 날짜: \(formatter.dateFormatter.string(from: checkInDate))")
                print("체크아웃 날짜: \(formatter.dateFormatter.string(from: checkOutDate))")
            }
            print("예약 금액: \(reservation.reservationFee)")
        }
    }
    
    func sortReservation() {
        reservations.sort { $0.checkInDate! < $1.checkInDate! }
        printReservationList()
    }
    
    func deleteReservation() {
        
        printReservationList()
        print("취소할 예약 번호를 입력하세요.")
        if let deleteReservNum = readLine(), let deleteReservNum = Int(deleteReservNum) {
            let currentDate = Date()
            
            if deleteReservNum > 0 && deleteReservNum <= reservations.count {
                let reservation = reservations[deleteReservNum - 1]
                if let checkInDate = reservation.checkInDate {
                    let dateDifference = currentDate.distance(to: checkInDate) / 86400 // 하루 86400초
                    if reservations[deleteReservNum-1].userName == user.currentUser {
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
                    } else {
                        print("본인의 예약만 취소할 수 있습니다.")
                    }
                }
            } else {
                print("잘못 입력하셨습니다.")
                deleteReservation()
            }
        } else {
            print("잘못 입력하셨습니다. 다시 입력해주세요.")
            deleteReservation()
        }
    }
    
    func changeRoom() {
        printReservationList()
        print("변경할 예약 번호를 입력하세요.")
        guard let changeReservNum = readLine(), let changeReservNum = Int(changeReservNum) else {
            print("잘못 입력하셨습니다. 다시 입력해주세요.")
            return changeRoom()
        }
        
        if reservations[changeReservNum-1].userName == user.currentUser {
            room.printRoomInfo()
            print("변경할 방 번호를 입력하세요.")
            while true {
                guard let changeRoomNum = readLine(), let changeRoomNum = Int(changeRoomNum) else {
                    print("잘못 입력하셨습니다. 다시 입력해주세요.")
                    continue
                }
                
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
        } else {
            print("본인의 예약만 변경할 수 있습니다.")
        }
    }
}

struct Reservation {
    var userName: String
    var roomNumber: Int
    let checkInDate: Date?
    let checkOutDate: Date?
    let reservationFee: Int
}
