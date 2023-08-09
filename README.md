# hotel_reservation

호텔 예약 프로그램

# 작업

![스크린샷 2023-07-20 오후 8.03.51.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/85d9478f-d846-436e-b4ea-85a6b58753fd/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-07-20_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_8.03.51.png)

- 왜 balance가 0 보다 작아져도 “잔액이 부족합니다” 가 출력되지않을까
    
    print(”\(reservationFee)”)로 확인해보니
    
    reservationFee가 86400000000 으로 나옴
    
    찾아보니 date.distance는 초단위로 나옴
    
    calculateFee의 return값을 86400으로 나누고 다시 실행해봄
    
    해결
    

![스크린샷 2023-07-20 오후 9.33.46.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/0b68a91d-4de0-4a6a-b75c-c540f96c2db8/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-07-20_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_9.33.46.png)

![스크린샷 2023-07-20 오후 9.34.05.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/93dcc3ee-e5f7-4afb-b5ea-62bbc45540cf/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-07-20_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_9.34.05.png)

- 왜?? 다르게 나오지?
    
    dateFormatter.dateFormat = "yyyy-MM-dd” 대문자로 변경하니까 잘됨 (mm은 minutes, MM은 months) 
    
    잘 되는줄 알았는데 날짜가 하나씩 밀린다
    
    print(”\(reservation.checkInDate)”)를
    
    print(”\(dataFormatter.string(from: reservation.checkInDate))”)
    
    스트링 타입으로 변경해서 해결
    

![스크린샷 2023-07-21 오전 9.47.06.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/5d924b48-df11-4720-a5ea-5108e2daf1e2/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-07-21_%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB_9.47.06.png)

- **Fatal error: Index out of range**
    
    생각해보니까 배열은 0부터 시작이니까 입력받은값에서 -1 해줘야한다.
    
    ![스크린샷 2023-07-21 오전 9.50.02.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/5bd24e63-ac6c-4603-bda0-57b08ab5f793/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-07-21_%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB_9.50.02.png)
