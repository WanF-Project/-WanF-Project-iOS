//
//  SignUpNetwork.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/06.
//

import Foundation

import RxSwift

class SignUpNetwork: WanfNetwork {
    let api = SignUpAPI()
    
    init() {
        super.init()
    }
    
    // 인증 번호 전송
    func sendVerificationCode(email: String) -> Single<Result<Void, WanfError>> {
        guard let url = api.sendVerificationCode().url else {
            return .just(.failure(.invalidURL))
        }
        
        let body = [ "email" : email ] as Dictionary<String, String>
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: body)
        
        return super.session.rx.data(request: request)
            .map { _ in
                return .success(Void())
            }
            .catch { error in
                    return .just(.failure(.networkError))
            }
            .asSingle()
    }
    
    // 인증 번호 검증
    func checkVerificationCode(email: String, verificationCode: String) -> Single<Result<Void, WanfError>> {
        guard let url = api.checkVerificationCode().url else {
            return .just(.failure(.invalidURL))
        }
        
        let body: Dictionary< String, String > = [
            "email" : email,
            "verificationCode" : verificationCode
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        return super.session.rx.data(request: request)
            .map { _ in
                return .success(Void())
            }
            .catch { error in
                return .just(.failure(.networkError))
            }
            .asSingle()
    }
    
    // 회원가입 완료
    func signUp(email: String, password: String) -> Single<Result<Void, WanfError>> {
        guard let url = api.signUp().url else {
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
            .map { response, _ in
                UserDefaultsManager.accessToken = response.value(forHTTPHeaderField: "authorization")
                UserDefaultsManager.refreshToken = response.value(forHTTPHeaderField: "x-refresh-token")
                
                return .success(Void())
            }
            .catch { _ in
                return .just(.failure(.networkError))
            }
            .asSingle()
    }
}
