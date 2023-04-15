//
//  FriendsMatchWritingViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/11.
//

import Foundation

import RxSwift
import RxCocoa

struct FriendsMatchWritingViewModel {
    
    let topBarViewModel = FriendsMatchWritingTopBarViewModel()
    
    // View -> ViewModel
    
    // ViewModel -> View
    let dismiss: Driver<Void>
    
    init() {
        
        dismiss = topBarViewModel.shouldDismiss
    }
}
