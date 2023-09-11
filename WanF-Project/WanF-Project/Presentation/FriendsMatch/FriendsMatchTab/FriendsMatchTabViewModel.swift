//
//  FriendsMatchTabViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/11.
//

import Foundation

import RxSwift
import RxCocoa

struct FriendsMatchTabViewModel {
    
    let disposeBag = DisposeBag()
    
    // View -> ViewModel
    let profileButtonTapped = PublishRelay<Void>()
    let searchButtonTapped = PublishRelay<Void>()
    let addButtonTapped = PublishRelay<Void>()
    let loadFriendsMatchList = PublishSubject<Void>()
    let refreshFriendsMatchList = PublishSubject<Void>()
    
    // Load Detail
    let loadDetailSubject = PublishSubject<Observable<Int>>()
    let loadDetailForNotification = PublishSubject<Int>()
    var loadDetailForSelectedItem = PublishSubject<Int>()
    let didTapNotification = PublishRelay<Int>()
    let didSelectItem = PublishRelay<Int>()
    
    // ViewModel -> View
    let cellData: Driver<[PostListResponseEntity]>
    let subject = PublishSubject<Observable<Void>>()
    
    let pushToProfile: Driver<ProfileMainViewModel>
    let pushToSearch: Driver<FriendsMatchSearchViewModel>
    let presentFriendsMatchWriting: Driver<FriendsMatchWritingViewModel>
    let pushToFriendsMatchDetail: Driver<FriendsMatchDetailViewModel>
    
    init(_ model: FriendsMatchTabModel = FriendsMatchTabModel()) {
        
        pushToProfile = profileButtonTapped
            .map { ProfileMainViewModel() }
            .asDriver(onErrorDriveWith: .empty())
        
        pushToSearch = searchButtonTapped
            .map{FriendsMatchSearchViewModel()}
            .asDriver(onErrorDriveWith: .empty())
        
        presentFriendsMatchWriting = addButtonTapped
            .map { FriendsMatchWritingViewModel() }
            .asDriver(onErrorDriveWith: .empty())
        
        //친구 찾기 List 데이터
        let friendsMatchListResult = subject
            .switchLatest()
            .flatMap(model.loadFriendsMatchList)
            .share()
        
        friendsMatchListResult.subscribe().disposed(by: disposeBag)
        
        subject.onNext(loadFriendsMatchList)
        
        let friendsMatchListValue = friendsMatchListResult
            .compactMap(model.getFriendsMatchListValue)
        
        cellData = friendsMatchListValue
            .asDriver(onErrorDriveWith: .empty())
        
        let friendsMatchListError = friendsMatchListResult
            .compactMap(model.getFriendsMatchListError)
        
        // Load Detail
        didSelectItem
            .withLatestFrom(cellData, resultSelector: { index, posts in
                posts[index].id
            })
            .bind(to: loadDetailForSelectedItem)
            .disposed(by: disposeBag)
        
        didTapNotification
            .bind(to: loadDetailForNotification)
            .disposed(by: disposeBag)
        
        pushToFriendsMatchDetail = loadDetailSubject
            .switchLatest()
            .map {
                FriendsMatchDetailViewModel(id: $0)
            }
            .asDriver(onErrorDriveWith: .empty())
        
    }
}
