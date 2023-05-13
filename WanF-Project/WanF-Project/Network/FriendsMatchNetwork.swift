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
    
    // 전체 글 조회
    func getAllPosts() -> Single<Result<[FriendsMatchListCellModel], WanfError>> {
        guard let accessToken = UserDefaultsManager.accessToken else {
            return .just(.failure(.invalidAuth))
        }
        
        guard let url = api.getAllPosts().url else {
            return .just(.failure(.invalidURL))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(accessToken, forHTTPHeaderField: "Authorization")
        
        return session.rx.data(request: request)
            .map { data in
                do {
                    let decodedData = try JSONDecoder().decode([FriendsMatchListCellModel].self, from: data)
                    print(decodedData)
                    return .success(decodedData)
                }
                catch {
                    return .failure(.invalidJSON)
                }
            }
            .catch({ error in
                return .just(.failure(.networkError))
            })
            .asSingle()
    }
    
}
