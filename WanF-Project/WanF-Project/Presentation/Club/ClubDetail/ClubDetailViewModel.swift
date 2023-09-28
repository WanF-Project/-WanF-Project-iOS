//
//  ClubDetailViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/22.
//

import Foundation

import RxSwift
import RxCocoa

struct ClubDetailViewModel {
    
    let disposeBag = DisposeBag()
    let id = PublishRelay<Int>()
    
    // View -> ViewModel
    let didTapAddButton = PublishRelay<Void>()
    
    let clubDetailSubject = PublishSubject<Observable<Void>>()
    let loadClubDetail = PublishSubject<Void>()
    let refreshClubDetail = PublishSubject<Void>()
    
    // ViewModel -> View
    let cellData: Driver<ClubPostListResponseEntity>
    let clubName = PublishRelay<String>()
    let presentClubWriting: Driver<ClubWritingViewModel>
    
    init(_ model: ClubDetailModel = ClubDetailModel()) {
        
        // Load ClubDetail
        let loadResult = clubDetailSubject
            .switchLatest()
            .withLatestFrom(id)
            .flatMap(model.loadAllClubPosts)
            .share()
        
        let loadValue = loadResult
            .compactMap(model.loadAllClubPostValue)
        
        let loadError = loadResult
            .compactMap(model.loadAllClubPostError)
        
        loadError
            .subscribe(onNext: {
                print("ERROR: \($0)")
            })
            .disposed(by: disposeBag)
        
        cellData = loadValue
            .asDriver(onErrorDriveWith: .empty())
        
        clubDetailSubject.onNext(loadClubDetail)
        
        // Present ClubWriting
        presentClubWriting = didTapAddButton
            .withLatestFrom(id)
            .map({ id in
                let viewModel = ClubWritingViewModel()
                viewModel.clubId.accept(id)
                return viewModel
            })
            .asDriver(onErrorDriveWith: .empty())
        
        presentClubWriting.drive().disposed(by: disposeBag)
    }
}

