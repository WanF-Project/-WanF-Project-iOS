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
    
    // Load List
    let loadListSubject = PublishSubject<Observable<Void>>()
    let loadMessageList = PublishSubject<Void>()
    let refreshMessageList = PublishSubject<Void>()
    
    let didSelectItem = PublishRelay<Int>()
    
    // ViewModel -> View
    let cellData: Driver<MessageListResponseEntity>
    let pushToMessageDetail: Driver<(ProfileResponseEntity, MessageDetailViewModel)>
    
    init(_ model: MessageListModel = MessageListModel()) {
        // Load MessageList
        let loadResult = loadListSubject
            .switchLatest()
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
        
        loadListSubject.onNext(loadMessageList)
        
        // Push MessageDetail
        pushToMessageDetail = didSelectItem
            .withLatestFrom(cellData, resultSelector: { index, list in
                (list[index], MessageDetailViewModel())
            })
            .asDriver(onErrorDriveWith: .empty())
    }
}
