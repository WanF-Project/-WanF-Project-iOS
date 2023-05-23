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
    let viewWillDismiss = PublishRelay<LectureInfoEntity>()
    
    // ViewModel -> View
    let cellData: Driver<[LectureInfoEntity]>
    var didSelectLectureInfo: Signal<LectureInfoEntity>
    
    let dismissAfterItemSelected: Driver<LectureInfoEntity>
    
    init(_ model: LectureInfoModel = LectureInfoModel()) {
        
        // 모든 강의 목록 조회
        let loadResult = model.loadAllCourses()
            .asObservable()
            .share()
        
        // 모든 강의 목록 조회 성공 - 데이터 목록 반영
        let loadValue = loadResult
            .compactMap(model.getAllCoursesValue)
        
        cellData = loadValue
            .asDriver(onErrorJustReturn: [])
        
        // TODO: - 모든 강의 목록 조회 실패
        let loadError = loadResult
            .compactMap(model.getAllCoursesError)
        
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

