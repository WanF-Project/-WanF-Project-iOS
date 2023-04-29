//
//  ProfileContentViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/28.
//

import Foundation

import RxSwift
import RxCocoa

struct ProfileContentViewModel {
    
    let personalityCellData: Driver<[String]>
    let purposeCellData: Driver<[String]>
    
    init() {
        
        // 임시 데이터
        personalityCellData = Observable
            .just([
                "Swift",
                "Java",
                "Java Script",
                "C",
                "C++",
                "Python"
            ])
            .asDriver(onErrorDriveWith: .empty())
        
        purposeCellData = Observable
            .just([
                "Python",
                "C",
                "Swift",
                "Java",
                "Java Script",
                "C++"
            ])
            .asDriver(onErrorDriveWith: .empty())
    }
}
