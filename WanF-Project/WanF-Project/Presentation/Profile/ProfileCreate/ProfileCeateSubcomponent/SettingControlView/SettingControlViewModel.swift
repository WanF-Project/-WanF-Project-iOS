//
//  SettingControlViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/06.
//

import Foundation

import RxSwift
import RxCocoa

struct SettingControlViewModel {
    
    let major = PublishRelay<MajorEntity>()
    let text: Driver<String>
    
    init() {
        text = major
            .map({ major in
                major.name ?? ""
            })
            .asDriver(onErrorDriveWith: .empty())
    }
    
}
