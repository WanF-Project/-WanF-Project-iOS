//
//  EmailStackViewCellModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/07.
//

import Foundation

import RxSwift

struct EmailStackViewCellModel {
    let network = SignUpNetwork()
    
    func sendEmail(_ email: String) -> Single<Result<Void, WanfError>>  {
        return network.sendVerificationCode(email: email)
    }
    
    func getEmailValue(_ result: Result<Void, WanfError>) -> Void? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    func getEmailError(_ result: Result<Void, WanfError>) -> String? {
        guard case .failure(let error) = result else {
            return nil
        }
        debugPrint("ERROR: \(error.localizedDescription)")
        return error.localizedDescription
    }
}
