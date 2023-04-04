//
//  SignInModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/04.
//

import Foundation

import RxSwift

// TODO: - 서버 연결 시 재구현
struct SignInModel {
    
    func signIn(_ signInData: (String?, String?)) -> Single<Bool> {
        return Observable
            .just(true)
            .asSingle()
    }
    
    func getSignInValue(_ result: Single<Bool>) -> Bool {
        return true
    }
    
    func getSignInError(_ result: Single<Bool>){
    }
}
