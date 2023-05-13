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
    
    // View -> ViewModel
    let profileButtonTapped = PublishRelay<Void>()
    let addButtonTapped = PublishRelay<Void>()
    let friendsMatchListItemSelected = PublishRelay<IndexPath>()
    
    // ViewModel -> View
    let cellData: Driver<[FriendsMatchListCellModel]>
    
    let pushToProfile: Driver<ProfileMainViewModel>
    let presentFriendsMatchWriting: Driver<FriendsMatchWritingViewModel>
    let pushToFriendsMatchDetail: Driver<(indexPath: IndexPath, viewModel: FriendsMatchDetailViewModel)>
    
    init(_ model: FriendsMatchTabModel = FriendsMatchTabModel()) {
        
        // View -> ViewModel
        
        pushToProfile = profileButtonTapped
            .map { ProfileMainViewModel() }
            .asDriver(onErrorDriveWith: .empty())
        
        presentFriendsMatchWriting = addButtonTapped
            .map { FriendsMatchWritingViewModel() }
            .asDriver(onErrorDriveWith: .empty())
        
        pushToFriendsMatchDetail = friendsMatchListItemSelected
            .map({ indexPath in
                return (indexPath, FriendsMatchDetailViewModel())
            })
            .asDriver(onErrorDriveWith: .empty())
        
        // ViewModel -> View
        
        //친구 찾기 List 데이터
        let friendsMatchListResult = model.loadFriendsMatchList()
            .asObservable()
            .share()
        
        let friendsMatchListValue = friendsMatchListResult
            .compactMap(model.getFriendsMatchListValue)
        
        cellData = friendsMatchListValue
            .asDriver(onErrorDriveWith: .empty())
        
        let friendsMatchListError = friendsMatchListResult
            .compactMap(model.getFriendsMatchListError)
        
    }
}
