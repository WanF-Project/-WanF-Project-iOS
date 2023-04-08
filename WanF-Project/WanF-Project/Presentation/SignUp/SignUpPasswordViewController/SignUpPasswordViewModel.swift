//
//  SignUpPasswordViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/04.
//

import Foundation

import RxSwift
import RxCocoa

struct SignUpPasswordViewModel {
    
    let passwordTextFieldCellViewModel = PasswordTextFieldCellViewModel()
    let passwordToCheckTextFieldCellViewModel = PasswordToCheckTextFieldCellViewModel()
    
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
        
        //비밀번호 일치 확인
        let password = passwordTextFieldCellViewModel.inputedPasswordText
            .compactMap { $0 }
        let passwordToCheck = passwordToCheckTextFieldCellViewModel.inputedPasswordToCheckText
            .compactMap { $0 }
        
        let combinedPassword = Observable
            .combineLatest(password, passwordToCheck)
        
        showGuidance = passwordToCheckTextFieldCellViewModel.passswordToCheckDidChange
            .asObservable()
            .withLatestFrom(combinedPassword)
            .map { (password, passwordToCheck) -> Bool in
                if password == passwordToCheck {
                    return false
                }
                return true
            }
            .asSignal(onErrorJustReturn: false)
        
    }
}
