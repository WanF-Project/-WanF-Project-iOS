//
//  ClubNetwork.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/17.
//

import Foundation

import RxSwift

class ClubNetwork: WanfNetwork {
    
    let api = ClubAPI()
    
    init() {
        super.init()
    }
    
    /// 모든 모임 조회
    func getAllClubs() -> Single<Result<[ClubResponseEntity], WanfError>> {
        guard let url = api.getAllClubs().url else {
            return .just(.failure(.invalidURL))
        }
        
        let request = UserDefaultsManager.accessTokenCheckedObservable
            .compactMap { $0 }
            .map { accessToken in
                var request = URLRequest(url: url)
                request.httpMethod = WanfHttpMethod.get.rawValue
                request.setValue(accessToken, forHTTPHeaderField: "Authorization")
                return request
            }
        
        return request
            .flatMap { request in
                super.session.rx.data(request: request)
            }
            .map { data in
                do {
                    let decoded = try JSONDecoder().decode([ClubResponseEntity].self, from: data)
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
    
    /// 모임 비밀번호 조회
    func getClubPassword(_ clubID: Int) -> Single<Result<ClubPwdRequestEntity, WanfError>> {
        guard let url = api.getClubPassword(clubID).url else {
            return .just(.failure(.invalidURL))
        }
        
        let request = UserDefaultsManager.accessTokenCheckedObservable
            .compactMap { $0 }
            .map { accessToken in
                var request = URLRequest(url: url)
                request.httpMethod = WanfHttpMethod.get.rawValue
                request.setValue(accessToken, forHTTPHeaderField: "Authorization")
                return request
            }
        
        return request
            .flatMap { request in
                super.session.rx.data(request: request)
            }
            .map { data in
                do {
                    let decoded = try JSONDecoder().decode(ClubPwdRequestEntity.self, from: data)
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
    
    /// 모임 생성
    func postCreateClub(_ club: ClubRequestEntity) -> Single<Result<Void, WanfError>> {
        guard let url = api.postCreateClub().url else {
            return .just(.failure(.invalidURL))
        }

        let requset = UserDefaultsManager.accessTokenCheckedObservable
            .compactMap { $0 }
            .map { accessToken in
                let body = try? JSONEncoder().encode(club)
                
                var request = URLRequest(url: url)
                request.httpMethod = WanfHttpMethod.post.rawValue
                request.setValue(accessToken, forHTTPHeaderField: "Authorization")
                request.setValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
                request.httpBody = body
                
                return request
            }
        
        return requset
            .flatMap {
                super.session.rx.data(request: $0)
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
