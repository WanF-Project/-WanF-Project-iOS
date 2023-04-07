//
//  VerifiedStackViewCellModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/07.
//

import Foundation

import RxSwift

// TODO: - 서버 연결 시 재구현
struct SignUpIDModel {
    
    func checkVerificationCode(_ code: String) -> Single<Bool> {
        return Observable
            .just(true)
            .asSingle()
    }
    
    func getVerificationValue(_ result: Bool) -> Bool? {
        if !result {
            return nil
        }
        return true
    }
    
    func getVerificationError(_ result: Bool) -> Bool? {
        if result {
            return nil
        }
        return false
    }
    
}
