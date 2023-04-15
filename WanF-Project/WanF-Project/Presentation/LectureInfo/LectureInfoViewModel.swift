//
//  LectureInfoViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/15.
//


import Foundation

import RxSwift
import RxCocoa

struct LectureInfoViewModel {
    
    // View -> ViewModel
    
    // ViewModel -> View
    let cellData: Driver<[LectureInfoModel]>
    
    init() {
        
        // View -> ViewModel
        
        
        // ViewModel -> View
        cellData = Observable
            .just(LectureInfoModel.lectureInfoCellData)
            .asDriver(onErrorJustReturn: [])
        
    }
}

