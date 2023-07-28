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
    
    let disposeBag = DisposeBag()
    
    // View -> ViewModel
    let shouldPresentCommentProfile = PublishRelay<IndexPath>()
    
    // ViewModel -> View
    let cellData: Driver<[CommentResponseEntity]>
    
    // ParentViewModel -> ViewModel
    let detailComments = PublishRelay<[CommentResponseEntity]>()
    
    init() {
        
        cellData = detailComments
            .asDriver(onErrorDriveWith: .empty())
    }
}
