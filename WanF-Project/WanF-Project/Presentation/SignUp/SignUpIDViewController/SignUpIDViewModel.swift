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
    
    // ViewModel -> View
    let cellData: Driver<[String]>
    
    let showGuidance: Signal<Bool>
    let pushToMainTabBar: Driver<SignUpPasswordViewModel>
    
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
        
        //다음 버튼
        let verificationCode = verifiedStackViewCellViewModel.inputedVerificationCode
            .compactMap { $0 }
        
        let verificationResult = nextButtonTapped
            .withLatestFrom(verificationCode)
            .flatMapLatest(model.checkVerificationCode)
            .share()
        
        let verificationValue = verificationResult
            .compactMap(model.getVerificationValue)
        
        pushToMainTabBar = verificationValue
            .map { _ in SignUpPasswordViewModel() }
            .asDriver(onErrorDriveWith: .empty())
        
        let verificationError = verificationResult
            .compactMap(model.getVerificationError)
        
        // TODO: - 인증번호가 일치하지 않을 시 Alert 메세지 전달
    }
}
