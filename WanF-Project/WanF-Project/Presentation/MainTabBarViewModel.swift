//
//  MainTabBarViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/04.
//

import Foundation

import RxSwift
import RxCocoa

enum WanfTabType {
    case friends
    case randomFriends
    case clubs
    case messages
}

struct MainTabBarViewModel {
    
    // Subcomponent ViewModel
    let friendsMaychViewModel = FriendsMatchTabViewModel()
    let randomFriendsViewModel = RandomFriendsViewModel()
    let clubViewModel = ClubListViewModel()
    let messageListViewModel = MessageListViewModel()
    
    // View -> ViewModel
    let didSelectTab = PublishRelay<WanfTabType>()
    
    // ViewModel -> View
    let selectedTab: Driver<WanfTabType>
    
    init() {
        
        selectedTab = didSelectTab
            .asDriver(onErrorJustReturn: .friends)
    }
}
