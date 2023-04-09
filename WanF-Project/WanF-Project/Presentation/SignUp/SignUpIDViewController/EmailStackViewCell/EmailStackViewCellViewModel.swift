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
    let shouldPresentAlertForError: Signal<AlertInfo>
    
    init(_ model: EmailStackViewCellModel = EmailStackViewCellModel()) {
        
        //이메일
        let ID = inputedIDText
            .compactMap { $0 }
        let emailAddress = Observable.just("@office.skhu.ac.kr")
        
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
        
        let alertInfo = emailError
            .map { _ in
                return (title: "이미 존재하는 이메일입니다", message: "")
            }
        
        shouldPresentAlertForError = alertInfo
            .asSignal(onErrorSignalWith: .empty())
        
    }
    
}
