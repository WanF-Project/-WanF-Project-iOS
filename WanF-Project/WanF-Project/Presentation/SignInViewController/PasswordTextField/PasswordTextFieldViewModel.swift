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
    
    let passwordData = PublishRelay<String?>()
    
}
