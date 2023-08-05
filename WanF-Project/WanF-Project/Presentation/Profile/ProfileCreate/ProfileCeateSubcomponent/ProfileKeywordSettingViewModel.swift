//
//  ProfileKeywordSettingViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/04.
//

import Foundation

import RxSwift
import RxCocoa

struct ProfileKeywordSettingViewModel {
    
    let cellData: Driver<[String]>
    
    init() {
        
        cellData = Observable
            .just(["임시 데이터", "임시 데이터", "임시 데이터", "임시 데이터", "임시 데이터", "임시 데이터", "임시 데이터"])
            .asDriver(onErrorDriveWith: .empty())
    }
}
