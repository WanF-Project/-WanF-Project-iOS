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
    let lectureInfoListItemSelected = PublishRelay<IndexPath>()
    
    // ViewModel -> View
    let cellData: Driver<[LectureInfoModel]>
    let dismiss: Driver<LectureInfoModel>
    
    init() {
        
        // View -> ViewModel
        dismiss = lectureInfoListItemSelected
            .withLatestFrom(cellData, resultSelector: { IndexPath, lectureInfoList in
                lectureInfoList[IndexPath.row]
            })
            .asDriver(onErrorDriveWith: .empty())
        
        // ViewModel -> View
        cellData = Observable
            .just(LectureInfoModel.lectureInfoCellData)
            .asDriver(onErrorJustReturn: [])
    }
}

