//
//  ClubListViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/16.
//

import Foundation

import RxSwift
import RxCocoa

struct ClubListViewModel {
    
    // View -> ViewModel
    let addButtonTapped = PublishRelay<Void>()
    
    // ViewModel -> View
    let presentAddActionSheet: Driver<Void>
    
    init() {
        presentAddActionSheet = addButtonTapped
            .asDriver(onErrorDriveWith: .empty())
    }
}
