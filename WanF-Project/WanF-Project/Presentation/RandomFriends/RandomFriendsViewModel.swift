//
//  File.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/14.
//

import Foundation

import RxSwift
import RxCocoa

class RandomPage {
    var header: Int = 3
    var isLast: Bool = false
    var nextPage: PageableEntity = PageableEntity(page: 0, size: 3, sort: [.latest])
    var page: Int = 0 {
        didSet {
            nextPage.page = page
        }
    }
    
    func clearRandomPage() {
        self.page = 0
        self.header = 3
        self.isLast = false
    }
}

class RandomFriendsViewModel {
    
    let disposeBag = DisposeBag()
    let randomPage = RandomPage()
    
    // Subcompontnt ViewModel
    let profileContentViewModel = ProfileContentViewModel()
    
    // View -> ViewModel
    let didLoadRandom = PublishRelay<Void>()
    let didSwipeProfile = PublishRelay<Void>()
    
    let randomSubject = PublishSubject<Observable<Void>>()
    let loadSubject = PublishSubject<Void>()
    let swipeSubject = PublishSubject<Void>()
    
    // ViewModel -> View
    let profiles: Observable<[ProfileResponseEntity]>
    let isHiddenForRefresh = PublishRelay<Bool>()
    
    init(_ model: RandomFriendsModel = RandomFriendsModel()) {
        
        // Load Random
        let loadResult = randomSubject
            .switchLatest()
            .withUnretained(randomPage, resultSelector: { randomPage, _ in
                if (randomPage.header >= 3) && !randomPage.isLast{
                    return randomPage.nextPage
                }
                return nil
            })
            .compactMap { $0 }
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
        
        didLoadRandom
            .bind(to: loadSubject)
            .disposed(by: disposeBag)
        
        didSwipeProfile
            .bind(to: swipeSubject)
            .disposed(by: disposeBag)
        
        // Set RandomPage
        loadValue
            .withUnretained(randomPage) { randomPage, response in
                randomPage.header = 0
                randomPage.isLast = response.last
                randomPage.page += 1
            }
            .subscribe()
            .disposed(by: disposeBag)
        
        // Bind Data to View
        profiles = loadValue
            .map { $0.content }
        
            profiles
            .withUnretained(randomPage, resultSelector: { randomPage, list in
                if randomPage.header < 3 {
                    let header = randomPage.header
                    randomPage.header += 1
                    return list[header]
                }
                return nil
            })
            .compactMap { $0 }
            .bind(to: profileContentViewModel.loadRandomProfile)
            .disposed(by: disposeBag)
        
        didSwipeProfile
            .withLatestFrom(profiles)
            .withUnretained(randomPage, resultSelector: { randomPage, list in
                if randomPage.header < 3 && randomPage.header < list.count {
                    let header = randomPage.header
                    randomPage.header += 1
                    return list[header]
                }
                else if randomPage.isLast {
                    self.isHiddenForRefresh.accept(false)
                }
                return nil
            })
            .compactMap { $0 }
            .bind(to: profileContentViewModel.loadRandomProfile)
            .disposed(by: disposeBag)
        
        // Initial Work
        randomSubject.onNext(loadSubject)
    }
}
