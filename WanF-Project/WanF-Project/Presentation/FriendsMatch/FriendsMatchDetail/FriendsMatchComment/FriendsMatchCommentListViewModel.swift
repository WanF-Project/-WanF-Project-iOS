//
//  FriendsMatchCommentListViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/16.
//

import Foundation

import RxSwift
import RxCocoa

struct FriendsMatchCommentListViewModel {
    
    // ViewModel -> View
    let cellData: Driver<[FriendsMatchCommentEntity]>
    
    init() {
        
        cellData = Observable
            .just(FriendsMatchCommentEntity.comments)
            .asDriver(onErrorJustReturn: [])
    }
}
