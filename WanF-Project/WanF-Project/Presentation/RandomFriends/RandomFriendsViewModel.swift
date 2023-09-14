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
    
    // Subcompontnt ViewModel
    let profileContentViewModel = ProfileContentViewModel()
    
    // View -> ViewModel
    let loadRandomFriends = PublishRelay<Void>()
    
    // ViewModel -> View
    
    init() {
        loadRandomFriends
            .subscribe(onNext: {
                print("LoadRandomFriends")
            })
    }
}
