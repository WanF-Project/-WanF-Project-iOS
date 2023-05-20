//
//  FriendsMatchWritingViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/11.
//

import Foundation

import RxSwift
import RxCocoa

struct FriendsMatchWritingViewModel {
    
    let disposeBag = DisposeBag()
    
    let topBarViewModel = FriendsMatchWritingTopBarViewModel()
    var friendsMatchWritingLectureInfoViewModel = FriendsMatchWritingLectureInfoViewModel()
    
    // View -> ViewModel
    let titleText = PublishRelay<String?>()
    let contentText = PublishRelay<String?>()
    
    let lectureInfo = PublishRelay<LectureInfEntity>()
    
    // ViewModel -> View
    let dismiss: Driver<Void>
    let presentAlert: Signal<Void>
    
    // ViewModel -> ChildViewModel
    let shouldSendLectureInfo: Observable<LectureInfEntity>
    let activateDoneButton: Driver<Bool>
    
    let isSelectedLectureInfo: Observable<Bool>
    let isDoneToWrite = PublishSubject<Bool>()
    
    // ChildViewModel -> ViewModel
    let createFriendsMatchDetailData = PublishRelay<Void>()
    
    init(_ model: FriendsMatchWritingModel = FriendsMatchWritingModel()) {
        
        shouldSendLectureInfo = lectureInfo
            .asObservable()
            .share()
        
        shouldSendLectureInfo
            .bind(to: friendsMatchWritingLectureInfoViewModel.lectureInfo)
            .disposed(by: disposeBag)
        
        //done 버튼 활성화 여부 결정
        isSelectedLectureInfo = shouldSendLectureInfo
            .map { _ in return true }
        
        activateDoneButton = Observable
            .combineLatest(isSelectedLectureInfo, isDoneToWrite, resultSelector: { isSelected, isDone in
                return isSelected && isDone
            })
            .asDriver(onErrorJustReturn: false)
        
        // 저장하기
        topBarViewModel.shouldSaveFriendsMatchDetailData
            .emit(to: createFriendsMatchDetailData)
            .disposed(by: disposeBag)
        
        let title = titleText
            .compactMap { $0 }
        
        let content = contentText
            .compactMap { $0 }
        
        let detailData = Observable
            .combineLatest(title, content, lectureInfo)
            .compactMap {
                FriendsMatchWritingEntity(title: $0, content: $1, lectureID: $2.id)
            }
        
        let saveResult = createFriendsMatchDetailData
            .withLatestFrom(detailData)
            .flatMap(model.saveFriendsMatchDetail)
            .share()
        
        let saveValue = saveResult
            .compactMap(model.getSavedFriendsMatchDetailValue)
        
        let saveError = saveResult
            .compactMap(model.getSavedFriendsMatchDetailError)
        
        // dismiss
        dismiss = saveValue
            .map { _ in }
            .amb(topBarViewModel.shouldDismiss)
            .asDriver(onErrorDriveWith: .empty())
        
        // prsernt Alert about Error
        presentAlert = saveError
            .map { _ in }
            .asSignal(onErrorSignalWith: .empty())
        
    }
}
