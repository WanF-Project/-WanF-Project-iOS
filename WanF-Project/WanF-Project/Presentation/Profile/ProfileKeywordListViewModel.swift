//
//  ProfileKeywordListViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/30.
//

import UIKit

import RxSwift
import RxCocoa

struct ProfileKeywordListViewModel {
    
    // View -> ViewModel
    
    // ViewModel -> View
    let cellData: Driver<[String]>
    
    init() {

        // 키워드 목록
        cellData = Observable
            .just(
                [
                    "1",
                    "2",
                    "3",
                    "4"
                ]
            )
            .asDriver(onErrorDriveWith: .empty())
    }
}



