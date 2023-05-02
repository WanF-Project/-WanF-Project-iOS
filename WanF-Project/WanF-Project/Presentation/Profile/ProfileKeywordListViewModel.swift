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
    
    //    let dismissAfterDoneButtonTapped: Driver<[String]>
    
    init() {

        // 키워드 목록
        cellData = Observable
            .just(
                [
                    "1",
                    "2",
                    "3",
                    "4"
                ]
            )
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
        
        // 완료 버튼 Tap 시 키워드 스트링으로 찾고 출력하기
        doneButtonTapped
            .withLatestFrom(keywordsSelected)
            .subscribe { list in
                print(list)
            }
        
        
        // 서버 전달 성공 시 Dismiss
        
    }
}
