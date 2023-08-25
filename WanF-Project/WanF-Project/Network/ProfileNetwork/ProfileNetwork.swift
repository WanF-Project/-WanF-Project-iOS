//
//  ProfileNetwork.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/28.
//

import Foundation

import RxSwift

class ProfileNetwork: WanfNetwork {
    
    let api = ProfilAPI()
    
    init() {
        super.init()
    }
    
    // 나의 프로필 조회
    func getMyProfile() -> Single<Result<ProfileResponseEntity, WanfError>> {
        
        guard let url = api.getMyProfile().url else {
            return .just(.failure(.invalidJSON))
        }
        
        let request = UserDefaultsManager.accessTokenCheckedObservable
            .map { accessToken in
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.setValue(accessToken, forHTTPHeaderField: "Authorization")
                return request
            }
        
        return request
            .flatMap { request in
                super.session.rx.data(request: request)
            }
            .map { data in
                do {
                    let decoded = try JSONDecoder().decode(ProfileResponseEntity.self, from: data)
                    return .success(decoded)
                }
                catch {
                    return .failure(.invalidJSON)
                }
            }
            .catch { error in
                    .just(.failure(.networkError))
            }
            .asSingle()
    }
    
    // 나의 프로필 수정
    func patchMyProfile(_ profile: ProfileRequestEntity) -> Single<Result<Void, WanfError>> {
        guard let url = api.patchMyProfile().url else {
            return .just(.failure(.invalidURL))
        }
        
        let request = UserDefaultsManager.accessTokenCheckedObservable
            .map { accessToken in
                let body = try? JSONEncoder().encode(profile)
                
                var request = URLRequest(url: url)
                request.httpMethod = "PATCH"
                request.setValue(accessToken, forHTTPHeaderField: "Authorization")
                request.setValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
                request.httpBody = body
                return request
            }
        
        return request
            .flatMap { request in
                super.session.rx.data(request: request)
            }
            .map { _ in
                return .success(Void())
            }
            .catch { error in
                return .just(.failure(.networkError))
            }
            .asSingle()
    }
    
    // 특정 프로필 조회
    func getSpecificProfile(_ id: Int) -> Single<Result<ProfileResponseEntity, WanfError>> {
        
        guard let url = api.getSpecificProfile(id).url else {
            return .just(.failure(.invalidURL))
        }
        
        let request = UserDefaultsManager.accessTokenCheckedObservable
            .map { accessToken in
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.setValue(accessToken, forHTTPHeaderField: "Authorization")
                
                return request
            }
        
        return request
            .flatMap { request in
                super.session.rx.data(request: request)
            }
            .map { data in
                do {
                    let decoded = try JSONDecoder().decode(ProfileResponseEntity.self, from: data)
                    return .success(decoded)
                }
                catch {
                    return .failure(.invalidJSON)
                }
            }
            .catch { error in
                return .just(.failure(.networkError))
            }
            .asSingle()
    }
    
    // 목표 리스트 조회
    func getKeywordGoalList() -> Single<Result<KeywordEntity, WanfError>> {
        guard let url = api.getKeyworkGoalList().url else {
            return .just(.failure(.invalidURL))
        }
        
        let request = UserDefaultsManager.accessTokenCheckedObservable
            .map { accessToken in
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.setValue(accessToken, forHTTPHeaderField: "Authorization")
                return request
            }
        
        return request
            .flatMap { request in
                super.session.rx.data(request: request)
            }
            .map { data in
                do {
                    let decoded = try JSONDecoder().decode(KeywordEntity.self, from: data)
                    return .success(decoded)
                }
                catch {
                    return .failure(.invalidJSON)
                }
            }
            .catch { error in
                    .just(.failure(.networkError))
            }
            .asSingle()
    }
    
    // 성격 리스트 조회
    func getKeywordPersonalityList() -> Single<Result<KeywordEntity, WanfError>> {
        guard let url = api.getKeywordPersonalityList().url else {
            return .just(.failure(.invalidURL))
        }
        
        let request = UserDefaultsManager.accessTokenCheckedObservable
            .map { accessToken in
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.setValue(accessToken, forHTTPHeaderField: "Authorization")
                return request
            }
        
        return request
            .flatMap { request in
                super.session.rx.data(request: request)
            }
            .map { data in
                do {
                    let decoded = try JSONDecoder().decode(KeywordEntity.self, from: data)
                    return .success(decoded)
                }
                catch {
                    return .failure(.invalidJSON)
                }
            }
            .catch { error in
                    .just(.failure(.networkError))
            }
            .asSingle()
    }
    
    /// 프로필 생성
    func postCreateProfile(_ profile: ProfileImageRequestEntity) -> Single<Result<Void, WanfError>> {
        guard let url = api.postCreateProfile().url else {
            return .just(.failure(.invalidURL))
        }
        
        let request = UserDefaultsManager.accessTokenCheckedObservable
            .compactMap { $0 }
            .map { accessToken in
                let body = try? JSONEncoder().encode(profile)
                var request = URLRequest(url: url)
                request.httpMethod = WanfHttpMethod.post.rawValue
                request.setValue(accessToken, forHTTPHeaderField: "Authorization")
                request.setValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
                request.httpBody = body
                return request
            }
        
        return request
            .flatMap {
                self.session.rx.data(request: $0)
            }
            .map { _ in
                    .success(Void())
            }
            .catch { error in
                    .just(.failure(.networkError))
            }
            .asSingle()
    }
}
