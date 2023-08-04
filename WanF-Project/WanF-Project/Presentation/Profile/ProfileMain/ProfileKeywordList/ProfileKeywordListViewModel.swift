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
    let cellData: Driver<KeywordEntity>
    let dismissAfterDoneButtonTapped: Driver<Void>
    
    init(_ model: ProfileKeywordListModel = ProfileKeywordListModel(), profile: ProfileResponseEntity?, type: ProfileKeywordType) {

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
            .withLatestFrom(cellData) { indexList, keywords in
                guard let keys = (keywords as NSDictionary).allKeys as? [String] else { return [String()] }
                var keywordsSelected: [String] = []
                
                for index in indexList {
                    keywordsSelected.append(keys[index.row])
                }
                return keywordsSelected
            }
        
        // 완료 버튼 Tap 시 서버 전달
        let saveResult = doneButtonTapped
            .withLatestFrom(keywordsSelected)
            .flatMap { keywords in
                model.saveProfileKeywordList(keywords, profile: profile!, type: type)
            }
            .share()
        
        let saveValue = saveResult
            .compactMap(model.getPatchProfileValue)
        
        let saveError = saveResult
            .compactMap(model.getPatchProfileError)
        
        // 서버 전달 성공 시 Dismiss
        dismissAfterDoneButtonTapped = saveValue
            .map{ _ in }
            .asDriver(onErrorDriveWith: .empty())
    }
}
