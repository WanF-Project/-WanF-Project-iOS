//
//  SignInAPI.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/09.
//

import Foundation

class SignInAPI: WanfAPI {
    
    //MARK: - Properties
    let path = "/api/v1/auth/"
    
    init() {
        super.init()
    }
    
    //MARK: - Function
    // 로그인
    func signIn() -> URLComponents {
        var components = URLComponents()
        components.scheme = super.scheme
        components.host  = super.host
        components.path = self.path + "login"
        
        return components
    }
}
