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
    
    // ParentViewModel -> ViewModel
    let detailComments = PublishRelay<[FriendsMatchCommentEntity]>()
    
    init() {
        
        cellData = detailComments
            .asDriver(onErrorDriveWith: .empty())
    }
}
