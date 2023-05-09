//
//  EmailTextFieldViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/04.
//

import Foundation

import RxSwift
import RxCocoa

struct EmailTextFieldViewModel {
    
    // View -> ViewModel
    let emailData = PublishRelay<String?>()
    
    // ViewModel -> ParentViewModel
    let email: Observable<String>
    
    init() {
        email = emailData
            .compactMap { $0 }
    }
}
