//
//  ClubListTableViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/17.
//

import Foundation

import RxSwift
import RxCocoa

typealias ClubInfo = (id: Int, name: String)

struct ClubListTableViewModel {
    
    // ParentViewModel -> ViewModel
    let shoulLoadClubs = PublishRelay<[ClubResponseEntity]>()
    
    // ViewModel -> ParentViewModel
    let shouldPushToClubDetail: Signal<ClubInfo>
    
    // View -> ViewModel
    let shareButtonTapped = PublishRelay<ClubResponseEntity>()
    let didSelectItem = PublishRelay<IndexPath>()
    
    // ViewModel -> View
    let cellData: Driver<[ClubResponseEntity]>
    
    
    init() {
        cellData = shoulLoadClubs
            .asDriver(onErrorDriveWith: .empty())
        
        shouldPushToClubDetail = didSelectItem
            .withLatestFrom(cellData, resultSelector: { indexPath, list in
                ClubInfo(indexPath.row, list[indexPath.row].name)
            })
            .asSignal(onErrorSignalWith: .empty())
    }
}
