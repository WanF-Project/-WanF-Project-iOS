//
//  BannerNetwork.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/10/29.
//

import Foundation

import RxSwift

class BannerNetwork: WanfNetwork {
    
    private let api = BannerAPI()
    
    init() {
        super.init()
    }
    
    
    /// 배너 조회
    func getBanners() -> Single<Result<BannerResponseEntity, WanfError>> {
        guard let url = api.getBanners().url else { return .just(.failure(.invalidURL)) }
        
        let request = UserDefaultsManager.accessTokenCheckedObservable
            .compactMap { $0 }
            .map { accessToken in
                var request = URLRequest(url: url)
                request.httpMethod = WanfHttpMethod.get.rawValue
                request.setValue(accessToken, forHTTPHeaderField: "Authorization")
                return request
            }
        
        return request
            .flatMap { super.session.rx.data(request: $0) }
            .map { data in
                do {
                    let decoded = try JSONDecoder().decode(BannerResponseEntity.self, from: data)
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
