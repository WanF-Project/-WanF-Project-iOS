//
//  SignUpAPI.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/06.
//

import Foundation

class SignUpAPI: WanfAPI {
    
    let path = "/api/v1/auth/signup/"
    
    init() {
        super.init()
        
    }
    
    // 인증 번호 전송
    func sendVerificationCode() -> URLComponents {
        var components = URLComponents()
        
        components.scheme = super.scheme
        components.host = super.host
        components.path = self.path + "verification-code"
        
        return components
    }
    
}
