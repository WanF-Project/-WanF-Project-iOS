//
//  FriendsMatchTabViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/11.
//

import Foundation

import RxSwift
import RxCocoa

class FriendsMatchTabViewModel {
    
    let disposeBag = DisposeBag()
    
    // Subcomponent ViewMode
    let FriendsMutipleListViewModel = FriendsMultipleListViewModel()
    
    // View -> ViewModel
    let profileButtonTapped = PublishRelay<Void>()
    let searchButtonTapped = PublishRelay<Void>()
    let addButtonTapped = PublishRelay<Void>()
    let loadFriendsMatchList = PublishSubject<Void>()
    let refreshFriendsMatchList = PublishSubject<Void>()
    
    // Load Detail
    let loadDetailSubject = PublishSubject<Observable<Int>>()
    let loadDetailForNotification = PublishSubject<Int>()
    var loadDetailForSelectedItem = PublishSubject<Int>()
    let didTapNotification = PublishRelay<Int>()
    let didSelectItem = PublishRelay<Int>()
    
    // ViewModel -> View
    let multipleCellData: Driver<[MultipleSectionModel]>
    let subject = PublishSubject<Observable<Void>>()
    
    let pushToProfile: Driver<ProfileMainViewModel>
    let pushToSearch: Driver<FriendsMatchSearchViewModel>
    let presentFriendsMatchWriting: Driver<FriendsMatchWritingViewModel>
    let pushToFriendsMatchDetail: Driver<FriendsMatchDetailViewModel>
    
    init(_ model: FriendsMatchTabModel = FriendsMatchTabModel()) {
        
        pushToProfile = profileButtonTapped
            .map { ProfileMainViewModel() }
            .asDriver(onErrorDriveWith: .empty())
        
        pushToSearch = searchButtonTapped
            .map{FriendsMatchSearchViewModel()}
            .asDriver(onErrorDriveWith: .empty())
        
        presentFriendsMatchWriting = addButtonTapped
            .map { FriendsMatchWritingViewModel() }
            .asDriver(onErrorDriveWith: .empty())
        
        //친구 찾기 List 데이터
        let friendsMatchListResult = subject
            .switchLatest()
            .flatMap(model.loadFriendsMatchList)
            .share()
        
        let friendsMatchListValue = friendsMatchListResult
            .compactMap(model.getFriendsMatchListValue)
        
        let postData = friendsMatchListValue

        let postCellData = postData
            .map { posts in
                MultipleSectionModel.PostSection(items: posts.map { SectionItem.PostItme($0) })
            }
        
        let friendsMatchListError = friendsMatchListResult
            .compactMap(model.getFriendsMatchListError)
        
        // Load Banner Data
        let loadBannerResult = subject
            .switchLatest()
            .flatMap(model.loadBanners)
            .share()
        
        let loadBannerValue = loadBannerResult
            .compactMap(model.loadBannersValue)
        
        let bannerCellData = loadBannerValue
            .map { banners in
                MultipleSectionModel.BannerSection(items: banners.map { SectionItem.BannerItem($0) })
            }
        
        let loadBannerError = loadBannerResult
            .compactMap(model.loadBannersError)
        
        loadBannerResult
            .subscribe(onNext: {
                print("ERROR: \($0)")
            })
            .disposed(by: disposeBag)
        
        // Set Multiple Cell Data
        multipleCellData = Observable
            .combineLatest(postCellData, bannerCellData, resultSelector: { [$1, $0] })
            .asDriver(onErrorDriveWith: .empty())
        
        // Load Detail
        didSelectItem
            .withLatestFrom(postData, resultSelector: { index, posts in
                posts[index].id
            })
            .bind(to: loadDetailForSelectedItem)
            .disposed(by: disposeBag)
        
        didTapNotification
            .bind(to: loadDetailForNotification)
            .disposed(by: disposeBag)
        
        pushToFriendsMatchDetail = loadDetailSubject
            .switchLatest()
            .map {
                FriendsMatchDetailViewModel(id: $0)
            }
            .asDriver(onErrorDriveWith: .empty())
        
        // Initialize
        friendsMatchListResult.subscribe().disposed(by: disposeBag)
        subject.onNext(loadFriendsMatchList)
        
    }
}
