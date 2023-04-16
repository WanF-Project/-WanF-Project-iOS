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
    let lectureInfo = PublishRelay<LectureInfoModel>()
    
    // ViewModel -> View
    let dismiss: Driver<Void>
    
    // ViewModel -> ChildViewModel
    let shouldSendLectureInfo: Observable<LectureInfoModel>
    let activateDoneButton: Driver<Bool>
    
    let isSelectedLectureInfo: Observable<Bool>
    let isDoneToWrite = PublishSubject<Bool>()
    
    init() {
        
        dismiss = topBarViewModel.shouldDismiss
        
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
    }
}
