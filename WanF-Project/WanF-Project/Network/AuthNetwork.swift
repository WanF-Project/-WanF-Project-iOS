//
//  SignInNetwork.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/09.
//

import Foundation

import RxSwift

class AuthNetwork: WanfNetwork {
    
    //MARK: - Properties
    let api = AuthAPI()
    
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

//MARK: - JWT Task
extension AuthNetwork {
    
    // AT 만료 여부 확인
    final func checkAuthorizationExpired() -> Single<Result<Void, WanfError>> {
        guard let accessToken = UserDefaultsManager.accessToken else {
            return .just(.failure(.invalidJSON))
        }
        
        guard let url = api.checkAuthorizationExpired().url else {
            return .just(.failure(.invalidURL))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(accessToken, forHTTPHeaderField: "Authorization")
        
        return session.rx.data(request: request)
            .map { _ in
                return .success(Void())
            }
            .catch { error in
                return .just(.failure(.networkError))
            }
            .asSingle()
    }
    
    // 토큰 재발급
    private func reissueAuthorization() -> Single<Result<Void, WanfError>> {
        
        guard let accessToken = UserDefaultsManager.accessToken,
              let refreshToken = UserDefaultsManager.refreshToken else {
            return .just(.failure(.invalidJSON))
        }
        
        guard let url = api.reissueAuthorization().url else {
            return .just(.failure(.invalidURL))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(accessToken, forHTTPHeaderField: "Authorization")
        request.setValue(refreshToken, forHTTPHeaderField: "X-Refresh-Token")
        
        return session.rx.response(request: request)
            .map { response, _ in
                UserDefaultsManager.accessToken = response.value(forHTTPHeaderField: "authorization")
                UserDefaultsManager.refreshToken = response.value(forHTTPHeaderField: "x-refresh-token")
                
                return .success(Void())
            }
            .catch { error in
                    .just(.failure(.networkError))
            }
            .asSingle()
    }
}
