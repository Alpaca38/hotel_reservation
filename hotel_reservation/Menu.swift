//
//  Menu.swift
//  hotel_reservation
//
//  Created by 조규연 on 2023/08/08.
//

import Foundation

class Menu {
    let menu = ["1. 랜덤금액 지급", "2. 호텔 방 정보", "3. 호텔 객실 예약 (10일 이상 예약 시 20% 할인)", "4. 나의 예약 목록 보기", "5. 나의 예약 목록 체크인 날짜 순으로 보기", "6. 예약 삭제", "7. 예약 수정", "8. 나의 입출금 내역 출력", "9. 나의 잔액 확인", "0. 종료"]
    
    func printMenu() {
        for i in 0..<menu.count {
            print(menu[i])
        }
    }

    func selectMenu() -> Int {
        print("호텔 예약 서비스")
        printMenu()
        let input = Int(readLine()!)!
        
        return input
    }
}
