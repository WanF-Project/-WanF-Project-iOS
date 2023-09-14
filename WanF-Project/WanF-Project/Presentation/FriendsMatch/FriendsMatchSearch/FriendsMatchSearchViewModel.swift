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
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    let pageable = Observable.just(PageableEntity(page: 0, size: 10, sort: [.latest]))
    
    // Subcomponent ViewModel
    let searchBarViewModel = CSSearchBarViewModel()
    
    // View -> ViewModel
    let didSelectItem = PublishRelay<IndexPath>()
    
    // ViewModel -> View
    let cellData: Driver<[PostListResponseEntity]>
    let pushToDetail: Driver<FriendsMatchDetailViewModel>
    
    init(_ model: FriendsMatchSearchModel = FriendsMatchSearchModel()) {
        
        // TODO: - Pageable하게 Refactoring
        // 검색
        let searchResult = searchBarViewModel.shouldSearch
            .asObservable()
            .withLatestFrom(pageable) { (searchWord: $0, pageable: $1) }
            .flatMap {
                model.searchPosts($0.searchWord, pageable: $0.pageable)
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
        
        // Push to Detail
        pushToDetail = didSelectItem
            .withLatestFrom(cellData, resultSelector: { indexPath, list in
                list[indexPath.row].id
            })
            .map { id in
              FriendsMatchDetailViewModel(id: id)
            }
            .asDriver(onErrorDriveWith: .empty())
        
    }
}
