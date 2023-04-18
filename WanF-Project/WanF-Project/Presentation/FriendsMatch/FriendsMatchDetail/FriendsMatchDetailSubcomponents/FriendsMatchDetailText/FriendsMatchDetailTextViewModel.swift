//
//  FriendsMatchDetailTextViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/18.
//

import Foundation

import RxSwift
import RxCocoa

struct FriendsMatchDetailTextViewModel {
    
    // View -> ViewModel
    
    // ViewModel -> View
    let loadDeatilText: Driver<(String, String)>
    
    // ParentViewModel -> ViewModel
    let detailText = PublishRelay<(String, String)>()
    
    init() {
        
        // View 데이터 전달
        loadDeatilText = detailText
            .asDriver(onErrorDriveWith: .empty())
        
    }
}
