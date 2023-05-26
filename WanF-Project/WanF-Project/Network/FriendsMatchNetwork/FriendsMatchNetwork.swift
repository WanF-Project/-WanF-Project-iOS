//
//  FriendsMatchNetwork.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/13.
//

import Foundation

import RxSwift

class FriendsMatchNetwork: WanfNetwork {
    
    //MARK: - Properties
    let api = FriendsMatchAPI()
    
    init() {
        super.init()
    }
    
    //MARK: - Function
    
    // 전체 게시글 조회
    func getAllPosts() -> Single<Result<[FriendsMatchListItemEntity], WanfError>> {
        
        guard let url = api.getAllPosts().url else {
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
                    let decoded = try JSONDecoder().decode([FriendsMatchListItemEntity].self, from: data)
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
    
    // 게시글 생성
    func createPost(_ post: FriendsMatchWritingEntity) -> Single<Result<Void, WanfError>> {
        guard let url = api.createPost().url else {
            return .just(.failure(.invalidURL))
        }
        
        let request = UserDefaultsManager
            .accessTokenCheckedObservable
            .map { accessToken in
                let body = try? JSONEncoder().encode(post)
                
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
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
                    .success(Void())
            }
            .catch { error in
                    .just(.failure(.networkError))
            }
            .asSingle()
    }
    
    // 특정 게시글 조회
    func getPostDetail(_ id: Int) -> Single<Result<FriendsMatchDetailEntity, WanfError>> {
        
        guard let url = api.getPostDetail(id).url else {
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
                    let decoded = try JSONDecoder().decode(FriendsMatchDetailEntity.self, from: data)
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
    
    // 게시글 삭제
    func deletePostDetail(_ id: Int) -> Single<Result<Void, WanfError>> {
        guard let url = api.deletePostDetail(id).url else {
            return .just(.failure(.invalidURL))
        }
        
        let request = UserDefaultsManager.accessTokenCheckedObservable
            .map { accessToken in
                var request = URLRequest(url: url)
                request.httpMethod = "DELETE"
                request.setValue(accessToken, forHTTPHeaderField: "Authorization")
                return request
            }
        
        return request
            .flatMap { request in
                super.session.rx.data(request: request)
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
