//
//  ProfileSingleSelectionListViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/06.
//

import UIKit

import RxSwift
import RxCocoa

struct ProfileSingleSelectionListViewModel {
    
    // View -> ViewModel
    let selectedItemIndex = PublishRelay<IndexPath>()
    
    // ViewModel -> View
    let cellData: Driver<[MajorEntity]>
    let selectedData: Observable<MajorEntity>
    let dismiss: Driver<Void>
    
    init(_ model: ProfileSingleSelectionListModel = ProfileSingleSelectionListModel(), profile: ProfileResponseEntity?, type: ProfileSingleSelectionType) {

        // 키워드 목록
        let singleListResult = model.getProfileSingleSelectionList(type)
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

