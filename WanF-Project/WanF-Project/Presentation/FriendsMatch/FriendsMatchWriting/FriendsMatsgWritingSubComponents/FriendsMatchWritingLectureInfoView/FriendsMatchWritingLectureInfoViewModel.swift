//
//  FriendsMatchWritingLectureInfoViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/16.
//

import Foundation

import RxSwift
import RxCocoa

struct FriendsMatchWritingLectureInfoViewModel {
    
    // View -> ViewModel
    let lectureName = PublishRelay<String>()
    let professorName = PublishRelay<String>()
    
    // ViewModel -> View
    let loadLectureInfo: Driver<CourseEntity>
    
    // ParentViewModel -> ViewModel
    let lectureInfo = PublishRelay<CourseEntity>()
    
    init() {
        
        // View -> ViewModel
        
        
        // ViewModel -> View
        
        
        // ParentViewModel -> ViewModel
        loadLectureInfo = lectureInfo
            .asDriver(onErrorDriveWith: .empty())
        
    }
}
