//
//  SignUpPasswordModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/08.
//

import Foundation

import RxSwift

struct SignUpPasswordModel {

    typealias SignUpInfo = (email: String, password: String)
    
    //MARK: - Properties
    let network = SignUpNetwork()
    
    //MARK: - Function
    
    func signUp(_ info: SignUpInfo) -> Single<Result<Void, WanfError>> {
        return network.signUp(email: info.email, password: info.password)
    }
    
    func getSignUpValue(_ result: Result<Void, WanfError>) -> Void? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    func getSignUpError(_ result: Result<Void, WanfError>) -> Void? {
        guard case .failure(let error) = result else {
            return nil
        }
        print("ERROR: \(error.localizedDescription)")
        return Void()
    }
}
