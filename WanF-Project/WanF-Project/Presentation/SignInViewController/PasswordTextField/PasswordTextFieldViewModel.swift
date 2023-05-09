//
//  PasswordTextFieldViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/04.
//

import Foundation

import RxSwift
import RxCocoa

struct PasswordTextFieldViewModel {
    
    // View -> ViewModel
    let passwordData = PublishRelay<String?>()
    
    // ViewModel -> ParentViewModel
    let password: Observable<String>
    
    init() {
        password = passwordData
            .compactMap { $0 }
    }
}
