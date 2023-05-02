//
//  ProfileKeywordListViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/30.
//

import UIKit

import RxSwift
import RxCocoa

struct ProfileKeywordListViewModel {
    
    // View -> ViewModel
    let doneButtonTapped = PublishRelay<Void>()
    let keywordIndexList = PublishRelay<[IndexPath]>()
    
    // ViewModel -> View
    let cellData: Driver<[String]>
    let dismissAfterDoneButtonTapped: Driver<Void>
    
    init(_ model: ProfileKeywordListModel = ProfileKeywordListModel(), type: ProfileKeywordType) {

        // 키워드 목록
        cellData = model.getProfileKeywordList(type)
            .asDriver(onErrorDriveWith: .empty())
        
        // 선택 된 아이템 정리
        let keywordsSelected = keywordIndexList
            .withLatestFrom(cellData) { indexList, keywords in
                var keywordsSelected: [String] = []
                
                for index in indexList {
                    keywordsSelected.append(keywords[index.row])
                }
                return keywordsSelected
            }
        
        // 완료 버튼 Tap 시 서버 전달
        let saveResult = doneButtonTapped
            .withLatestFrom(keywordsSelected)
            .flatMap { keywords in
                model.saveProfileKeywordList(keywords, type: type)
            }
            .share()
        
        let saveValue = saveResult
            .compactMap(model.getSavedProfileKeywordListValue)
        
        let saveError = saveResult
            .compactMap(model.getSavedProfileKeywordListError)
        
        // 서버 전달 성공 시 Dismiss
        dismissAfterDoneButtonTapped = saveValue
            .map{ _ in }
            .asDriver(onErrorDriveWith: .empty())
    }
}
