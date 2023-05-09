//
//  VerifiedStackViewCellModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/07.
//

import Foundation

import RxSwift

struct SignUpIDModel {
    
    typealias VerificationInfo = (email: String, code: String)
    
    //MARK: - Properties
    let network = SignUpNetwork()
    
    //MARK: - Function
    
    func checkVerificationCode(_ info: VerificationInfo) -> Single<Result<Void, WanfError>> {
        
        return network.checkVerificationCode(email: info.email, verificationCode: info.code)
    }
    
    func getVerificationValue(_ result: Result<Void, WanfError>) -> Void? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    func getVerificationError(_ result: Result<Void, WanfError>) -> Void? {
        guard case .failure(let error) = result else {
            return nil
        }
        print("ERROR: \(error.localizedDescription)")
        return Void()
    }
    
}
