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
    
    let disposeBag = DisposeBag()
    
    // View -> ViewModel
    var loadMessageDetail = PublishRelay<Int>()
    
    // ViewModel -> View
    var senderNickname = PublishRelay<String>()
    var messages: Driver<[MessageEntity]>
    var currentUser: Driver<SenderEntity>
    
    init(_ model: MessageDetailModel = MessageDetailModel()) {
        
        // Load MessageDetail
        let loadResult = loadMessageDetail
            .flatMap(model.loadMessageDetail)
            .share()
        
        let loadValue = loadResult
            .compactMap(model.loadMessageDetailValue)
            .share()
        
        let loadError = loadResult
            .compactMap(model.loadMessageDetailError)
        
        loadError
            .subscribe(onNext: {
                print("ERROR: \($0)")
            })
            .disposed(by: disposeBag)
        
        currentUser = loadValue
            .map { SenderEntity(senderId: String($0.myProfileId)) }
            .asDriver(onErrorDriveWith: .empty())
        
        messages = loadValue
            .map { response in
                response.messages.map {
                    let sender = SenderEntity(senderId: String($0.senderProfileId))
                    return MessageEntity(sender: sender, sentDate: $0.createDate, content: $0.content)
                }
            }
            .asDriver(onErrorDriveWith: .empty())
    }
}
