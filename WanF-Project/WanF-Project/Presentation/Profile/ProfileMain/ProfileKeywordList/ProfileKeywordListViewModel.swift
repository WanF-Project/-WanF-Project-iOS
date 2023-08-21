//
//  ProfileKeywordListViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/30.
//

import UIKit

import RxSwift
import RxCocoa

typealias KeywordDictionary = (keys: [String], values: [String])

struct ProfileKeywordListViewModel {
    
    // View -> ViewModel
    let doneButtonTapped = PublishRelay<Void>()
    let keywordIndexList = PublishRelay<[IndexPath]>()
    
    // ViewModel -> View
    let cellData: Driver<KeywordEntity>
    let dismissAfterDoneButtonTapped: Driver<Void>
    
    // ViewModel -> Parent ViewModel
    let selectedData: Observable<KeywordDictionary>
    
    init(_ model: ProfileKeywordListModel = ProfileKeywordListModel(), type: ProfileKeywordType) {

        // 키워드 목록 서버 연결
        let keywordResult = model.getProfileKeywordList(type)
            .asObservable()
            .share()
        
        // 키워드 목록 서버 연결 성공 - 목록 할당
        let keywordValue = keywordResult
            .compactMap(model.getProfileKeywordListValue)
        
        cellData = keywordValue
            .asDriver(onErrorJustReturn: KeywordEntity())
        
        let keywordError = keywordResult
            .compactMap(model.getProfileKeywordListError)
        
        // 선택 된 아이템 정리
        let keywordsSelected = keywordIndexList
            .withLatestFrom(cellData) { (indexList: $0, keywordDict: $1) }
            .map {
                let keys = ($0.keywordDict as NSDictionary).allKeys as? [String] ?? []
                let values = ($0.keywordDict as NSDictionary).allValues as? [String] ?? []
                var selectedKeys: [String] = []
                var selectedValues: [String] = []

                for index in $0.indexList {
                    selectedKeys.append(keys[index.row])
                    selectedValues.append(values[index.row])
                }
                return (keys: selectedKeys, values: selectedValues)
            }
        
        selectedData = doneButtonTapped
            .withLatestFrom(keywordsSelected)
        
        // Dismiss
        dismissAfterDoneButtonTapped = selectedData
            .map{ _ in }
            .asDriver(onErrorDriveWith: .empty())
    }
}
