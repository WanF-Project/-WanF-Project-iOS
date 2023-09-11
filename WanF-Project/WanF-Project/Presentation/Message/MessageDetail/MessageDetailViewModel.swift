//
//  MessageDetailViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/05.
//

import Foundation

import RxSwift
import RxCocoa

class MessageDetailViewModel {
    
    let disposeBag = DisposeBag()
    
    // View -> ViewModel
    let loadMessageDetail = PublishRelay<Void>()
    let didTapSendButton = PublishRelay<String>()
    
    let id = PublishRelay<Int>()
    
    // ViewModel -> View
    var senderNickname = PublishRelay<String>()
    var messages: Driver<[MessageEntity]>
    var currentUser: Driver<SenderEntity>
    var newMessage: Observable<MessageEntity>
    var addNewMessage: Driver<MessageEntity>
    
    init(_ model: MessageDetailModel = MessageDetailModel()) {
        
        // Load MessageDetail
        let loadResult = loadMessageDetail
            .withLatestFrom(id)
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
        
        // Send Message
        newMessage = didTapSendButton
            .withLatestFrom(currentUser) { text, user in
                MessageEntity(sender: user, sentDate: Date().formatted(), content: text)
            }
        
        let sendResult = didTapSendButton
            .withLatestFrom(id) { text, id in
                MessageRequestEntity(receiverProfileId: id, content: text)
            }
            .flatMap(model.sendMessage)
            .share()
        
        let sendValue = sendResult
            .compactMap(model.sendMessageValue)
        
        let sendError = sendResult
            .compactMap(model.sendMessageError)
        
        sendError
            .subscribe(onNext: {
                print("ERROR: \($0)")
            })
            .disposed(by: disposeBag)
        
        addNewMessage = sendValue
            .withLatestFrom(newMessage)
            .asDriver(onErrorDriveWith: .empty())
        
    }
}
