//
//  CourseInfoListViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/15.
//


import UIKit

import RxSwift
import RxCocoa

struct CourseInfoListViewModel {
    
    // Properties
    let disposeBag = DisposeBag()
    
    // Subcomponent ViewModel
    let searchBarViewModel = CSSearchBarViewModel()
    
    // View -> ViewModel
    let shouldLoad = PublishRelay<Void>()
    let lectureInfoListItemSelected = PublishRelay<IndexPath>()
    let viewWillDismiss = PublishRelay<CourseEntity>()
    
    // ViewModel -> View
    let cellData: Driver<[CourseEntity]>
    var didSelectLectureInfo: Signal<CourseEntity>
    
    let dismissAfterItemSelected: Driver<CourseEntity>
    
    let subject = PublishSubject<Observable<[CourseEntity]>>()
    let loadValueSubject = PublishSubject<[CourseEntity]>()
    let searchValueSubject = PublishSubject<[CourseEntity]>()
    
    init(_ model: CourseInfoListModel = CourseInfoListModel()) {
        
        // 모든 강의 목록 조회
        let loadResult = shouldLoad
            .flatMap(model.loadAllCourses)
            .share()
        
        let loadValue = loadResult
            .compactMap(model.getAllCoursesValue)
        
        loadValue
            .withLatestFrom(Observable.just((subject, loadValueSubject))){
                (
                    value: $0,
                    subject: $1.0,
                    loadSubject: $1.1
                )
            }
            .subscribe(onNext: {
                $0.subject.onNext($0.loadSubject)
                $0.loadSubject.onNext($0.value)
            })
            .disposed(by: disposeBag)
            
        // TODO: - 모든 강의 목록 조회 실패
        let loadError = loadResult
            .compactMap(model.getAllCoursesError)
        
        // 강의 목록 반영
        cellData = subject
            .switchLatest()
            .asDriver(onErrorDriveWith: .empty())
        
        //아이템 선택 시 dismiss되도록
        dismissAfterItemSelected = lectureInfoListItemSelected
            .withLatestFrom(cellData, resultSelector: { IndexPath, lectureInfoList in
                lectureInfoList[IndexPath.row]
            })
            .asDriver(onErrorDriveWith: .empty())
        
        //dismiss할 때 이전 화면으로 데이터 전달
        didSelectLectureInfo = viewWillDismiss
            .asSignal(onErrorSignalWith: .empty())

        // 강의 정보 검색
        let searchResult = searchBarViewModel.shouldSearch
            .asObservable()
            .flatMap(model.searchCourse)
            .share()
        
        let searchValue = searchResult
            .compactMap(model.getSearchCourseValue)
        
        searchValue
            .withLatestFrom(Observable.just((subject, searchValueSubject))) {
                (value: $0, subject: $1.0, searchSubject: $1.1)
            }
            .subscribe(onNext: {
                $0.subject.onNext($0.searchSubject)
                $0.searchSubject.onNext($0.value)
            })
            .disposed(by: disposeBag)
        
        // TODO: - 오류 작업
        let searchError = searchResult
            .compactMap(model.getSearchCourseError)
        
    }
}

