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
    let createClubTapped = PublishRelay<Void>()
    let joinClubTapped = PublishRelay<Void>()
    
    // ViewModel -> View
    let presentAddActionSheet: Driver<Void>
    let presentCreateAlert: Driver<Void>
    let presentJoinAlert: Driver<Void>
    let createClub: Single<Void>
    let joinClub: Single<Void>
    
    init() {
        presentAddActionSheet = addButtonTapped
            .asDriver(onErrorDriveWith: .empty())
        
        presentCreateAlert = createActionTapped
            .asDriver(onErrorDriveWith: .empty())
        
        presentJoinAlert = joinActionTapped
            .asDriver(onErrorDriveWith: .empty())
        
        // TODO: - 서버 연결 시 로직 수정
        createClub = createClubTapped
            .asSingle()
        
        joinClub = joinClubTapped
            .asSingle()
    }
}
