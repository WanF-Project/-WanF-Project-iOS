//
//  MessageDetailViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/05.
//

import Foundation

import RxSwift
import RxCocoa

struct MessageDetailViewModel {
    
    // ViewModel -> View
    var messages: Driver<[MessageEntity]>
    var sender: Driver<SenderEntity>
    
    init() {
        let data = [ MessageEntity(sender: SenderEntity(senderId: "2", displayName: "원프2"), messageId: "1234", sentDate: Date(), content: "수업 친구 매칭 서비스. 같이 수업을 듣고 정보를 공유할 친구를 찾을 수 있도록 장을 제공하는 성공회대학교 전용 플랫폼입니다."),
                     MessageEntity(sender: SenderEntity(senderId: "1", displayName: "원프1"), messageId: "1234", sentDate: Date(), content: "수업 친구 매칭 서비스. 같이 수업을 듣고 정보를 공유할 친구를 찾을 수 있도록 장을 제공하는 성공회대학교 전용 플랫폼입니다.")]
        messages = Observable.just(data)
            .asDriver(onErrorDriveWith: .empty())
        
        sender = Observable.just(SenderEntity(senderId: "1", displayName: "Wanf"))
            .asDriver(onErrorDriveWith: .empty())
    }
}
