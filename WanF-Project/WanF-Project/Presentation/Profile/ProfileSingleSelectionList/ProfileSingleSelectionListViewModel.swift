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
    let cellData: Driver<[String]>
    let dismiss: Driver<Void>
    
    init(_ model: ProfileSingleSelectionListModel = ProfileSingleSelectionListModel(), type: ProfileSingleSelectionType) {

        // 키워드 목록
        cellData = model.getProfileSingleSelectionList(type)
            .asDriver(onErrorDriveWith: .empty())
        
        // 아이템 선택 시 서버 전달
        let saveResult = selectedItemIndex
            .withLatestFrom(cellData) { IndexPath, list in
                list[IndexPath.row]
            }
            .flatMap({ item in
                model.saveProfileSingleSelectionList(item, type: type)
            })
            .share()
        
        let saveValue = saveResult
            .compactMap(model.getSavedProfileSingleSelectionListValue)
        
        let saveError = saveResult
            .compactMap(model.getSavedProfileSingleSelectionListError)
        
        // 서버 전달 성공 시 Dismiss
        dismiss = saveValue
            .map{ _ in }
            .asDriver(onErrorDriveWith: .empty())
    }
}

