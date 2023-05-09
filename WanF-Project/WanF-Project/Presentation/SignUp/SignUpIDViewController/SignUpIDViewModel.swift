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
    let verifiedStackViewCellViewModel = VerifiedStackViewCellViewModel()
    
    // View -> ViewModel
    let nextButtonTapped = PublishRelay<Void>()
    let preButtonTapped = PublishRelay<Void>()
    
    // ViewModel -> View
    let cellData: Driver<[String]>
    
    let showGuidance: Signal<Bool>
    let pushToSignUpPassword: Driver<SignUpPasswordViewModel>
    let popToSignIn: Driver<Void>
    let presentAlertForEmailError: Signal<AlertInfo>
    let presentAlertForVerificationError: Signal<AlertInfo>
    
    init(_ model: SignUpIDModel = SignUpIDModel()) {
        
        self.cellData = Observable
            .just([
                "EmailStackViewCell",
                "VerifiedStackViewCell",
                "AlertMessageCell"
            ])
            .asDriver(onErrorJustReturn: [])
        
        showGuidance = emailStackViewCellViewModel.shouldLoadGuidance
            .asSignal(onErrorJustReturn: false)
        
        // 다음 버튼 - 인증 번호 검사
        let email = emailStackViewCellViewModel.email
        
        let verificationCode = verifiedStackViewCellViewModel.verificationCode
        
        let verificationResult = nextButtonTapped
            .withLatestFrom(email)
            .withLatestFrom(verificationCode, resultSelector: { return ($0, $1) })
            .flatMapLatest(model.checkVerificationCode)
            .share()
        
        let verificationValue = verificationResult
            .compactMap(model.getVerificationValue)
        
        let verificationError = verificationResult
            .compactMap(model.getVerificationError)
        
        // 인증 번호 검증 성공
        pushToSignUpPassword = verificationValue
            .withLatestFrom(emailStackViewCellViewModel.inputedIDText)
            .compactMap { $0 }
            .map { email in SignUpPasswordViewModel(email: email) }
            .asDriver(onErrorDriveWith: .empty())
        
        // 인증 번호 검증 실패
        presentAlertForVerificationError = verificationError
            .map { _ in
                return (title: "인증번호가 일치하지 않습니다", message: "")
            }
            .asSignal(onErrorSignalWith: .empty())
        
        //이전 버튼
        popToSignIn = preButtonTapped
            .asDriver(onErrorDriveWith: .empty())
        
        //이메일 중복 오류 Alert
        presentAlertForEmailError = emailStackViewCellViewModel.shouldPresentAlertForError
            .asSignal(onErrorSignalWith: .empty())
    }
}
