//
//  CSSearchBarViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/07/28.
//

import Foundation

import RxSwift
import RxCocoa

struct CSSearchBarViewModel {
    
    // View -> ViewModel
    let searchButtonTapped = PublishRelay<Void>()
    let searchWord = PublishRelay<String?>()
    
    // ViewModel -> Parent View
    var shouldSearch: Signal<String>
    
    init() {
        
        // 검색하기
        shouldSearch = searchButtonTapped
            .withLatestFrom(
                searchWord
                .compactMap { $0 }
                .filter { !$0.isEmpty }
            )
            .asSignal(onErrorJustReturn: String())
    }
}
