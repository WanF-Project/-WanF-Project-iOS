//
//  MessageListViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/01.
//

import Foundation

import RxSwift
import RxCocoa

struct MessageListViewModel {
    
    // ViewModel -> View
    let cellData: Driver<MessageListResponseEntity>
    
    init() {
        let tempData = MessageListResponseEntity([
            ProfileResponseEntity(id: 1, nickname: "원프", major: MajorEntity(id: 11, name: "전공 정보"), studentId: 12039, age: 12, gender: ["" : ""], mbti: "MBTI", personalities: ["" : ""], goals: ["" : ""], image: ImageResponseEntity(imageId: 1, imageUrl: ""))
        ])
        
        
        cellData = Observable.of(tempData)
            .asDriver(onErrorDriveWith: .empty())
    }
}
