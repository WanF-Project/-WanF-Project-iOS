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
    let doneButtonTapped = PublishRelay<Void>()
    
    // ViewModel -> View
    let shouldDismiss: Observable<Void>
    
    // ViewModel -> ParentViewModel
    let shouldSaveFriendsMatchDetailData: Signal<Void>
    
    init() {
        
        // View -> ViewModel
        shouldDismiss = cancelButtonTapped
            .asObservable()
        
        shouldSaveFriendsMatchDetailData = doneButtonTapped
            .asSignal()
        
        // ViewModel -> View
        
    }
}
