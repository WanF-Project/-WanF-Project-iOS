//
//  File.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/14.
//

import Foundation

import RxSwift
import RxCocoa

struct RandomFriendsViewModel {
    
    let disposeBag = DisposeBag()
    var nextPage = Observable.just(PageableEntity(page: 0, size: 3, sort: [.latest]))
    var index = Observable.just(0)
    var isLast = Observable.just(false)
    
    // Subcompontnt ViewModel
    let profileContentViewModel = ProfileContentViewModel()
    
    // View -> ViewModel
    let loadRandomFriends = PublishRelay<Void>()
    
    // ViewModel -> View
    let profiles: Observable<[ProfileResponseEntity]>
    
    init(_ model: RandomFriendsModel = RandomFriendsModel()) {
        
        // Load Random Friends
        let loadResult = loadRandomFriends
            .withLatestFrom(nextPage)
            .flatMap(model.loadRandomFriends)
            .share()
        
        let loadValue = loadResult
            .compactMap(model.loadRandomFriendsValue)
            .share()
        
        let loadError = loadResult
            .compactMap(model.loadRandomFriendsError)
        
        loadError
            .subscribe(onNext: {
                print("ERROR: \($0)")
            })
            .disposed(by: disposeBag)
        
        nextPage = loadValue
            .map {
                PageableEntity(page: $0.number + 1, size: $0.size, sort: [.latest])
            }
        
        profiles = loadValue
            .map { response in
                response.content
            }
        
        profiles
            .withLatestFrom(index, resultSelector: { list, index in
                list[index]
            })
            .bind(to: profileContentViewModel.loadRandomProfile)
            .disposed(by: disposeBag)
    }
}
