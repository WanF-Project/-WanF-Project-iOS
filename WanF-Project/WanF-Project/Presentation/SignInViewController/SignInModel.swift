//
//  SignInModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/04.
//

import Foundation

import RxSwift

struct SignInModel {
    
    typealias SignInInfo = (email: String, password: String)
    
    //MARK: - Properties
    let network = AuthNetwork()
    
    //MARK: - Function
    
    func signIn(_ info: SignInInfo) -> Single<Result<Void, WanfError>> {
        return network.signIn(email: info.email, password: info.password)
    }
    
    func getSignInValue(_ result: Result<Void, WanfError>) -> Void? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    func getSignInError(_ result: Result<Void, WanfError>) -> Void? {
        guard case .failure(let error) = result else {
            return nil
        }
        print("ERROR: \(error.localizedDescription)")
        return Void()
    }
}
