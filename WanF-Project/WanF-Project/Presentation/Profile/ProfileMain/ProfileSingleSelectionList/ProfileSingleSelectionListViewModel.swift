//
//  ProfileSingleSelectionListViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/06.
//

import UIKit

import RxSwift
import RxCocoa

struct ProfileSingleSelectionListViewModel<T: Nameable> {
    
    // View -> ViewModel
    let selectedItemIndex = PublishRelay<IndexPath>()
    
    // ViewModel -> View
    let cellData: Driver<[T]>
    let selectedData: Observable<T>
    let dismiss: Driver<Void>
    
    init(_ model: ProfileSingleSelectionListModel<T> = ProfileSingleSelectionListModel()) {

        // 키워드 목록
        let singleListResult = model.getProfileSingleSelectionList()
            .asObservable()
            .share()
        
        let singleListValue = singleListResult
            .compactMap(model.getProfileSingleSelectionListValue)
        
        cellData = singleListValue
            .asDriver(onErrorDriveWith: .empty())
        
        selectedData = selectedItemIndex
            .withLatestFrom(cellData) { IndexPath, list in
                list[IndexPath.row]
            }
        
        dismiss = selectedData
            .map { _ in }
            .asDriver(onErrorDriveWith: .empty())
    }
}

