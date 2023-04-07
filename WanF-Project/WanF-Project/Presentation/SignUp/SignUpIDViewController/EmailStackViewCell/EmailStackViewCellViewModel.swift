//
//  EmailStackViewCellViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/07.
//

import Foundation

import RxSwift
import RxCocoa

struct EmailStackViewCellViewModel {
    
    // View -> ViewModel
    let inputedIDText = PublishRelay<String?>()
    let sendEmailButtonTapped = PublishRelay<Void>()
    
    // ViewModel -> View
    let shouldLoadGuidance: Observable<Bool>
    
    init(_ model: EmailStackViewCellModel = EmailStackViewCellModel()) {
        
        //이메일
        let ID = inputedIDText
            .compactMap { $0 }
        let emailAddress = Observable.just("@")
        
        let emailText = Observable
            .combineLatest(ID, emailAddress) { ID,  address in
                ID + address
            }
        
        //전송 버튼
        let sendEmailResult = sendEmailButtonTapped
            .withLatestFrom(emailText)
            .flatMapLatest(model.sendEmail)
            .share()
        
        let emailValue = sendEmailResult
            .compactMap(model.getEmailValue)
        
        shouldLoadGuidance = emailValue
        
        let emailError = sendEmailResult
            .compactMap(model.getEmailError)
        
        // TODO: - 이미 생성된 이메일 오류 메세지 표시하기
        
    }
    
}
