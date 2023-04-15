//
//  FriendsMatchWritingTopBarViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/15.
//

import Foundation

import RxSwift
import RxCocoa

struct FriendsMatchWritingTopBarViewModel {
    
    // View -> ViewModel
    let cancelButtonTapped = PublishRelay<Void>()
    
    // ViewModel -> View
    let shouldDismiss: Driver<Void>
    
    init() {
        
        // View -> ViewModel
        shouldDismiss = cancelButtonTapped
            .asDriver(onErrorDriveWith: .empty())
        
        // ViewModel -> View
        
    }
}
