//
//  SignUpIDViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/03.
//

import Foundation

import RxSwift
import RxCocoa

struct SignUpIDViewModel {
    
    let emailStackViewCellViewModel = EmailStackViewCellViewModel()
    
    let cellData: Driver<[String]>
    
    init() {
        self.cellData = Observable
            .just([
                "EmailStackViewCell",
                "VerifiedStackViewCell",
                "AlertMessageCell"
            ])
            .asDriver(onErrorJustReturn: [])
    }
}
