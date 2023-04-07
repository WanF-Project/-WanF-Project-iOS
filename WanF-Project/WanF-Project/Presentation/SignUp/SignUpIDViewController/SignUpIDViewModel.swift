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
    
    // View -> ViewModel
    
    // ViewModel -> View
    let cellData: Driver<[String]>
    
    let showGuidance: Signal<Bool>
    
    init() {
        self.cellData = Observable
            .just([
                "EmailStackViewCell",
                "VerifiedStackViewCell",
                "AlertMessageCell"
            ])
            .asDriver(onErrorJustReturn: [])
        
        showGuidance = emailStackViewCellViewModel.shouldLoadGuidance
            .asSignal(onErrorJustReturn: false)
    }
}
