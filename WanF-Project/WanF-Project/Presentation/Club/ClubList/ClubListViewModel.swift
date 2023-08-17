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
    
    // Properties
    let disposeBag = DisposeBag()
    
    // Subcomponent ViewModel
    let clubListTableViewModel = ClubListTableViewModel()
    
    // View -> ViewModel
    let loadAllClubs = PublishRelay<Void>()
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
    
    init(_ model: ClubListModel = ClubListModel()) {
        
        // Load All Clubs
        let loadResult = loadAllClubs
            .flatMap(model.getAllClubs)
            .share()
        
        let loadValue = loadResult
            .compactMap(model.getAllClubsValue)
        
        let loadError = loadResult
            .compactMap(model.getAllClubsError)
        
        // Bind ClubListTableView
        loadValue
            .bind(to: clubListTableViewModel.shoulLoadClubs)
            .disposed(by: disposeBag)
        
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
