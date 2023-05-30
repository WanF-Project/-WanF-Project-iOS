//
//  MajorNetwork.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/30.
//

import Foundation

import RxSwift

class MajorNetwork: WanfNetwork {
    
    let api = MajorAPI()
    
    init() {
        super.init()
    }
    
    // 모든 전공 조회
    func getAllMajors<T: Decodable>() -> Single<Result<[T], WanfError>> {
        
        guard let url = api.getAllMajors().url else {
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
                    let decoded = try JSONDecoder().decode([T].self, from: data)
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
}
