//
//  RandomNetwork.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/14.
//

import Foundation

import RxSwift
import RxCocoa

class RandomNetwork: WanfNetwork {
     
    let api = RandomAPI()
    
    /// 랜덤 프로필 조회
    func getRandomProfiles(_ pageable: PageableEntity) -> Single<Result<SlicePageableResponseEntity<ProfileResponseEntity>, WanfError>> {
        guard let url = api.getRandomProfiles(pageable).url else {
            return .just(.failure(.invalidURL))
        }
        
        let request = UserDefaultsManager.accessTokenCheckedObservable
            .compactMap { $0 }
            .map { accessToken in
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.setValue(accessToken, forHTTPHeaderField: "Authorization")
                return request
            }
        
        return request
            .flatMap {
                super.session.rx.data(request: $0)
            }
            .map { data in
                do {
                    let decoded = try JSONDecoder().decode(SlicePageableResponseEntity<ProfileResponseEntity>.self, from: data)
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
