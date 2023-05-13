//
//  LectureInfoViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/15.
//


import UIKit

import RxSwift
import RxCocoa

struct LectureInfoViewModel {
    
    // View -> ViewModel
    let lectureInfoListItemSelected = PublishRelay<IndexPath>()
    let viewWillDismiss = PublishRelay<LectureInfoModel>()
    
    // ViewModel -> View
    let cellData: Driver<[LectureInfoModel]>
    var didSelectLectureInfo: Signal<LectureInfoModel>
    
    let dismissAfterItemSelected: Driver<LectureInfoModel>
    
    init() {
        
        // View -> ViewModel
        
        // ViewModel -> View
        cellData = Observable
            .just([])
            .asDriver(onErrorJustReturn: [])
        
        //아이템 선택 시 dismiss되도록
        dismissAfterItemSelected = lectureInfoListItemSelected
            .withLatestFrom(cellData, resultSelector: { IndexPath, lectureInfoList in
                lectureInfoList[IndexPath.row]
            })
            .asDriver(onErrorDriveWith: .empty())
        
        //dismiss할 때 이전 화면으로 데이터 전달
        didSelectLectureInfo = viewWillDismiss
            .asSignal(onErrorSignalWith: .empty())
    }
}

