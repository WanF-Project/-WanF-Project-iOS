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
                "느긋함",
                "효율중시",
                "계획적",
                "꼼꼼함",
                "밝은",
                "조용함"
            ])
            .asDriver(onErrorDriveWith: .empty())
        
        purposeCellData = Observable
            .just([
                "과탑",
                "친목",
                "앞자리",
                "뒷자리",
                "평타",
                "놀자"
            ])
            .asDriver(onErrorDriveWith: .empty())
    }
}
