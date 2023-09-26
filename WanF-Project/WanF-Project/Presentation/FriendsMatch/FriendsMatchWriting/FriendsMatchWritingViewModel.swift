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
    
    // Subcomponent ViewModel
    let topBarViewModel = FriendsMatchWritingTopBarViewModel()
    let friendsMatchWritingLectureInfoViewModel = FriendsMatchWritingLectureInfoViewModel()
    let titleViewModel = WritingTextViewModel()
    let contentViewModel = WritingTextViewModel()
    
    // View -> ViewModel
    let titleText = PublishRelay<String?>()
    let contentText = PublishRelay<String?>()
    
    let lectureInfo = PublishRelay<CourseEntity>()
    
    // ViewModel -> View
    let dismiss: Driver<Void>
    let presentAlert: Signal<Void>
    
    // ViewModel -> ChildViewModel
    let shouldSendLectureInfo: Observable<CourseEntity>
    let activateDoneButton: Driver<Bool>
    
    let isSelectedLectureInfo: Observable<Bool>
    let isDoneToWrite: Observable<Bool>
    
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
            .map { _ in true }
        
        isDoneToWrite = Observable
            .combineLatest(titleViewModel.shouldActiveDoneButton, contentViewModel.shouldActiveDoneButton, resultSelector: { isTitleDone, isContentDone in
                return isTitleDone && isContentDone
            })
        
        activateDoneButton = Observable
            .combineLatest(isSelectedLectureInfo, isDoneToWrite, resultSelector: { isSelected, isDone in
                return isSelected && isDone
            })
            .asDriver(onErrorJustReturn: false)
        
        // 새로운 글 생성
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
                PostRequestEntity(title: $0, content: $1, lectureID: $2.id)
            }
        
        let saveResult = createFriendsMatchDetailData
            .withLatestFrom(detailData)
            .flatMap(model.createFriendsMatchDetail)
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
