//
//  FriendsMatchDetailInfoViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/18.
//

import Foundation

import RxSwift
import RxCocoa

struct FriendsMatchDetailInfoViewModel {
    
    // View -> ViewModel
    
    // ViewModel -> View
    let loadDeatilInfo: Driver<(String, String)>
    
    // ParentViewModel -> ViewModel
    let detailInfo = PublishRelay<(String, String)>()
    
    init() {
        
        // View 데이터 전달
        loadDeatilInfo = detailInfo
            .asDriver(onErrorDriveWith: .empty())
        
    }
}
