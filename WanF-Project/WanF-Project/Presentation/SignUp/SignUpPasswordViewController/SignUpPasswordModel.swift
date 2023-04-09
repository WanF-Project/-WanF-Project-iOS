//
//  SignUpPasswordModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/08.
//

import Foundation

import RxSwift

// TODO: - 서버 연결 시 재구현
struct SignUpPasswordModel {
    
    func signUp(_ signUpData: (String, String)) -> Single<Bool> {
        return Observable
            .just(true)
            .asSingle()
    }
    
    func getSignUpValue(_ result: Bool) -> Bool? {
        if !result {
            return nil
        }
        return true
    }
    
    func getSignUpError(_ result: Bool) -> Bool? {
        if result {
            return nil
        }
        return false
    }
}
