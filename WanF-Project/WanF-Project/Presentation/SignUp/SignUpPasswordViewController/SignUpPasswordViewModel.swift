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
    let preButtonTapped = PublishRelay<Void>()
    let doneButtonTapped = PublishRelay<Void>()
    
    // ViewModel -> View
    let cellData: Driver<[String]>
    let showGuidance: Signal<Bool>
    let enableDoneButton: Driver<Bool>
    
    let popToSignUpID: Driver<Void>
    let presentMainTabBar: Driver<MainTabBarViewModel>
    let presentAlertForSignUpError: Signal<AlertInfo>
    
    init(email: String, _ model: SignUpPasswordModel = SignUpPasswordModel()) {
        
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
        
        //완료 버튼 활성화
        enableDoneButton = showGuidance
            .map { isShownGuidance -> Bool in
                if isShownGuidance {
                    return false
                }
                return true
            }
            .asDriver(onErrorJustReturn: false)
        
        //완료 버튼
        let signUpData = Observable
            .combineLatest(Observable.just(email), password)

        let signUpResult = doneButtonTapped
            .withLatestFrom(signUpData)
            .flatMap(model.signUp)
            .share()
        
        let signUpValue = signUpResult
            .compactMap(model.getSignUpValue)
        
        presentMainTabBar = signUpValue
            .map { _ in
                return MainTabBarViewModel()
            }
            .asDriver(onErrorDriveWith: .empty())
        
        let signUpError = signUpResult
            .compactMap(model.getSignUpError)
        
        presentAlertForSignUpError = signUpError
            .map { _ in
                // TODO: - 오류 상태코드 별 메세지 지정
                return (title: "회원가입 실패", message: "")
            }
            .asSignal(onErrorSignalWith: .empty())
        
        //이전 화면으로 전환
        popToSignUpID = preButtonTapped
            .asDriver(onErrorDriveWith: .empty())
    }
}
