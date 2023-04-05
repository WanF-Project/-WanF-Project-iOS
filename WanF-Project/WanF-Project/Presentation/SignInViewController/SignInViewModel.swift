//
//  SignInViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/04.
//

import Foundation

import RxSwift
import RxCocoa

struct SignInViewModel {
    
    let emailTextFieldViewModel = EmailTextFieldViewModel()
    let passwordTextFieldViewModel = PasswordTextFieldViewModel()
    
    // ViewModel -> View
    let presentAlert: Signal<Void>
    let pushToMainTabBar: Driver<MainTabBarViewModel>
    let pushToSignUpID: Driver<SignUpIDViewModel>
    
    // View -> ViewModel
    let signInButtonTapped = PublishRelay<Void>()
    let signUpButtonTapped = PublishRelay<Void>()
    
    init(_ model: SignInModel = SignInModel()) {
        
        // 로그인 데이터 조합
        let signInData = Observable
            .combineLatest(emailTextFieldViewModel.emailData, passwordTextFieldViewModel.passwordData)
        
        // 로그인 시도
        let signInResult = signInButtonTapped
            .withLatestFrom(signInData)
            .map(model.signIn)
            .share()
        
        //로그인 성공
        let signInValue = signInResult
            .compactMap(model.getSignInValue)
        
        //로그인 성공 시 메인 화면 전환
        pushToMainTabBar = signInValue
            .map { _ in
                return MainTabBarViewModel()
            }
            .asDriver(onErrorDriveWith: .empty())
        
        //로그인 실패
        let signInError = signInResult
            .compactMap(model.getSignInError)
        
        // 로그인 시도 실패 시 Alert 표시
        presentAlert = signInError
            .asSignal(onErrorSignalWith: .empty())
        
        
        
        // 회원가입 화면 전환
        pushToSignUpID = signUpButtonTapped
            .map { _ in
                return SignUpIDViewModel()
            }
            .asDriver(onErrorDriveWith: .empty())
        
    }
}