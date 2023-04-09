//
//  EmailStackViewCellModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/07.
//

import Foundation

import RxSwift

// TODO: - 서버 연결 시 재구현
struct EmailStackViewCellModel {
    
    func sendEmail(_ email: String) -> Single<Bool>  {
        return Observable
            .just(true)
            .asSingle()
    }
    
    func getEmailValue(_ result: Bool) -> Bool? {
        if !result {
            return nil
        }
        return true
    }
    
    func getEmailError(_ result: Bool) -> Bool? {
        if result {
            return nil
        }
        return true
    }
}
