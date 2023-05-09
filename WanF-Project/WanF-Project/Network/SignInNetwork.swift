//
//  SignInNetwork.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/09.
//

import Foundation

import RxSwift

class SignInNetwork: WanfNetwork {
    
    //MARK: - Properties
    let api = SignInAPI()
    
    init() {
        super.init()
    }
    
    // 로그인
    func signIn(email: String, password: String) -> Single<Result<Void, WanfError>> {
        guard let url = api.signIn().url else {
            return .just(.failure(.invalidURL))
        }
        
        let body: Dictionary<String, String> = [
            "email" : email,
            "userPassword" : password
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        return super.session.rx.response(request: request)
            .map { response, data in
                guard let accessToken = response.value(forHTTPHeaderField: "authorization"),
                      let refreshToken = response.value(forHTTPHeaderField: "x-refresh-token")
                else {
                    return .failure(.invalidJSON)
                }
                
                UserDefaultsManager.accessToken = accessToken
                UserDefaultsManager.refreshToken = refreshToken
                
                return .success(Void())
            }
            .catch { error in
                    .just(.failure(.networkError))
            }
            .asSingle()
    }
}
