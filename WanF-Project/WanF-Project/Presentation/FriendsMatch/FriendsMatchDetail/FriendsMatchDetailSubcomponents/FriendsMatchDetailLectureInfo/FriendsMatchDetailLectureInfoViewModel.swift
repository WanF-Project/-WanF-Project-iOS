//
//  FriendsMatchDetailLectureInfoViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/18.
//

import Foundation

import RxSwift
import RxCocoa

struct FriendsMatchDetailLectureInfoViewModel {
    
    // View -> ViewModel
    
    // ViewModel -> View
    let loadDetailLectureInfo: Driver<LectureInfoModel>
    
    // ParentViewModel -> ViewModel
    var detailLectureInfo = PublishRelay<LectureInfoModel>()
    
    init() {
        
        // View 데이터 전달
        loadDetailLectureInfo = detailLectureInfo
            .asDriver(onErrorDriveWith: .empty())
        
    }
}