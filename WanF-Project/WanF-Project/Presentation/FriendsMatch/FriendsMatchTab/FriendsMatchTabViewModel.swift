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
    
    // ViewModel -> View
    let shouldLoadFriendsMatchList:  Observable<Bool>
    let cellData: Driver<[FriendsMatchListCellModel]>
    
    let pushToProfile: Driver<ProfileViewModel>
    
    init(_ model: FriendsMatchTabModel = FriendsMatchTabModel()) {
        
        // View -> ViewModel
        
        pushToProfile = profileButtonTapped
            .map { ProfileViewModel() }
            .asDriver(onErrorDriveWith: .empty())
        
        
        // ViewModel -> View
        
        //친구 찾기 List 데이터
        shouldLoadFriendsMatchList = model.loadFriendsMatchList()
        
        let friendsMatchListResult = shouldLoadFriendsMatchList
            .share()
        
        let friendsMatchListValue = friendsMatchListResult
            .compactMap(model.getFriendsMatchListValue)
        
        cellData = friendsMatchListValue
            .asDriver(onErrorDriveWith: .empty())
        
        let friendsMatchListError = friendsMatchListResult
            .compactMap(model.getFriendsMatchListError)
        
    }
}
