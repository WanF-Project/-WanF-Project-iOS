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
    
    // Load Detail
    let loadDetailSubject = PublishSubject<Observable<MessageDetailViewModel>>()
    let loadDetailForNotification = PublishSubject<MessageDetailViewModel>()
    var loadDetailForSelectedItem = PublishSubject<MessageDetailViewModel>()
    let didTapNotification = PublishRelay<Int>()
    let didSelectItem = PublishRelay<Int>()
    
    // ViewModel -> View
    let cellData: Driver<MessageListResponseEntity>
    let pushToMessageDetail: Driver<MessageDetailViewModel>
    
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
        
        didSelectItem
            .withLatestFrom(cellData, resultSelector: { index, list in
                let viewModel = MessageDetailViewModel()
                viewModel.senderNickname.accept(list[index].nickname)
                viewModel.id.accept(list[index].id)
                return viewModel
            })
            .bind(to: loadDetailForSelectedItem)
            .disposed(by: disposeBag)
        
        didTapNotification
            .map { id in
                let viewModel = MessageDetailViewModel()
                viewModel.id.accept(id)
                return viewModel
            }
            .bind(to: loadDetailForNotification)
            .disposed(by: disposeBag)
        
        
        pushToMessageDetail = loadDetailSubject
            .switchLatest()
            .asDriver(onErrorDriveWith: .empty())
    }
}
