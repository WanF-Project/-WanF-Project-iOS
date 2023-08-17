//
//  ClubListTableViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/17.
//

import Foundation

import RxSwift
import RxCocoa

struct ClubListTableViewModel {
    
    // ParentViewModel -> ViewModel
    let shoulLoadClubs = PublishRelay<[ClubResponseEntity]>()
    
    // ViewModel -> View
    let cellData: Driver<[ClubResponseEntity]>
    
    
    init() {
        cellData = shoulLoadClubs
            .asDriver(onErrorDriveWith: .empty())
    }
}
