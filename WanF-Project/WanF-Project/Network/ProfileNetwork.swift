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
}
