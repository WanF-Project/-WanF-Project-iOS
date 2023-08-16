//
//  ClubListViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/16.
//

import Foundation

import RxSwift
import RxCocoa

struct ClubListViewModel {
    
    // View -> ViewModel
    let addButtonTapped = PublishRelay<Void>()
    let createActionTapped = PublishRelay<Void>()
    let joinActionTapped = PublishRelay<Void>()
    
    // ViewModel -> View
    let presentAddActionSheet: Driver<Void>
    let presentCreateAlert: Driver<Void>
    let presentJoinAlert: Driver<Void>
    
    init() {
        presentAddActionSheet = addButtonTapped
            .asDriver(onErrorDriveWith: .empty())
        
        presentCreateAlert = createActionTapped
            .asDriver(onErrorDriveWith: .empty())
        
        presentJoinAlert = joinActionTapped
            .asDriver(onErrorDriveWith: .empty())
    }
}
