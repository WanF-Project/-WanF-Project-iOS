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
    let friendsMatchListItemSelected = PublishRelay<Int>()
    let loadFriendsMatchList = PublishSubject<Void>()
    let refreshFriendsMatchList = PublishSubject<Void>()
    
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
        loadFriendsMatchList.onNext(Void())
        
        let friendsMatchListValue = friendsMatchListResult
            .compactMap(model.getFriendsMatchListValue)
        
        cellData = friendsMatchListValue
            .asDriver(onErrorDriveWith: .empty())
        
        let friendsMatchListError = friendsMatchListResult
            .compactMap(model.getFriendsMatchListError)
        
        // 목록 아이템 선택
        pushToFriendsMatchDetail = friendsMatchListItemSelected
            .withLatestFrom(cellData, resultSelector: { index, posts in
                posts[index]
            })
            .map({ post in
                return FriendsMatchDetailViewModel(id: post.id)
            })
            .asDriver(onErrorDriveWith: .empty())
        
    }
}
