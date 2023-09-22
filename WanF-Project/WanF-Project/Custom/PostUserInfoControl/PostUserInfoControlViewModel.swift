//
//  PostUserInfoControlViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/22.
//

import Foundation

import RxSwift
import RxCocoa

struct PostUserInfoControlViewModel {
    
    // View -> ViewModel
    let didTapUserInfo = PublishRelay<Void>()
    
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

