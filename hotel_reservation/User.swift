//
//  User.swift
//  hotel_reservation
//
//  Created by 조규연 on 2023/08/08.
//

import Foundation

class User {
    var currentUser: String?
    
    func login() {
        //terminator: 줄바꿈을 어떻게 처리할지 나타내는 매개변수
        print("사용자 이름을 입력하세요: ", terminator: "")
        if let userName = readLine() {
            currentUser = userName
            print("환영합니다, \(userName)님!")
        }
    }
    
    func logout() {
        currentUser = nil
        print("성공적으로 로그아웃 하였습니다.")
    }
}
