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
    let shouldLoadFriendsMatchList:  Observable<Bool>
    
    // ViewModel -> View
    let cellData: Driver<[FriendsMatchListCellModel]>
    
    init(_ model: FriendsMatchTabModel = FriendsMatchTabModel()) {
        
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
