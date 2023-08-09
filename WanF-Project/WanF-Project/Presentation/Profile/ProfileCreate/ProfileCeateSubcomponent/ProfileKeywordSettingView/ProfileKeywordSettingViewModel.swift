//
//  ProfileKeywordSettingViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/04.
//

import Foundation

import RxSwift
import RxCocoa

struct ProfileKeywordSettingViewModel {
    
    // Parent ViewModel -> ViewModel
    let keywords = PublishRelay<KeywordDictionary>()
    
    // ViewModel -> View
    let cellData: Driver<[String]>
    
    // ViewModel -> Parent ViewModel
    let keyOfItems: Observable<[String]>
    let valueOfItems: Observable<[String]>
    
    init() {
        
        let items = keywords
            .asObservable()
            .share()
        
        keyOfItems = items
            .map { $0.keys }
        
        valueOfItems = items
            .map { $0.values }
        
        cellData = valueOfItems
            .asDriver(onErrorDriveWith: .empty())
    }
}
