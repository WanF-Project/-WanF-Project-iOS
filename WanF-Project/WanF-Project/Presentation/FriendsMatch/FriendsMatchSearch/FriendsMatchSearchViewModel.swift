//
//  FriendsMatchSearchViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/07/30.
//

import Foundation

import RxSwift
import RxCocoa

struct FriendsMatchSearchViewModel {
    
    let disposeBag = DisposeBag()
    
    // Subcomponent ViewModel
    let searchBarViewModel = CSSearchBarViewModel()
    
    // ViewModel -> View
    let cellData: Driver<[PostListResponseEntity]>
    
    init(_ model: FriendsMatchSearchModel = FriendsMatchSearchModel()) {
        
        // 검색
        let searchResult = searchBarViewModel.shouldSearch
            .asObservable()
            .flatMap { searchWord in
                model.searchPosts(searchWord, pageable: PageableEntity(page: 0, size: 3, sort: [.latest]))
            }
            .share()
        
        let searchValue = searchResult
            .compactMap(model.searchValue)
        
        let searchError = searchResult
            .compactMap(model.searchError)
        
        searchError
            .subscribe()
            .disposed(by: disposeBag)
        
        // 검색된 게시글 목록
        cellData = searchValue
            .map({ pageable in
                pageable.content
            })
            .asDriver(onErrorDriveWith: .empty())
        
    }
}
