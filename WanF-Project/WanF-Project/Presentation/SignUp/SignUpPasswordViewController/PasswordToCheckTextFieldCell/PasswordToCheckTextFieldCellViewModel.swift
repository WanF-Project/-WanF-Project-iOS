//
//  PasswordToCheckTextFieldCellViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/08.
//

import Foundation

import RxSwift
import RxCocoa

struct PasswordToCheckTextFieldCellViewModel {
    
    // View -> ViewModel
    let inputedPasswordToCheckText = PublishRelay<String?>()
    let passswordToCheckDidChange = PublishRelay<Void>()
    
}
