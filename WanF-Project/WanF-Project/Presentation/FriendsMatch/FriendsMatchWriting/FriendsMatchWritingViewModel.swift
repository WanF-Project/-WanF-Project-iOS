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
    
    init() {
        
        dismiss = topBarViewModel.shouldDismiss
        
        shouldSendLectureInfo = lectureInfo
            .asObservable()
        
        shouldSendLectureInfo
            .bind(to: friendsMatchWritingLectureInfoViewModel.lectureInfo)
            .disposed(by: disposeBag)
    }
}
