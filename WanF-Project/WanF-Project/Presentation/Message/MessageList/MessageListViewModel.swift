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
    let disposeBag = DisposeBag()
    // View -> ViewModel
    let loadMessageList = PublishRelay<Void>()
    
    // ViewModel -> View
    let cellData: Driver<MessageListResponseEntity>
    
    init(_ model: MessageListModel = MessageListModel()) {
        // Load MessageList
        let loadResult = loadMessageList
            .flatMap(model.loadMessageList)
            .share()
        
        let loadValue = loadResult
            .compactMap(model.loadMessageListValue)
        
        let loadError = loadResult
            .compactMap(model.loadMessageListError)
        
        loadError.subscribe(onNext: {
            print("ERROR: \($0)")
        })
        .disposed(by: disposeBag)
        
        cellData = loadValue
            .asDriver(onErrorDriveWith: .empty())
    }
}
