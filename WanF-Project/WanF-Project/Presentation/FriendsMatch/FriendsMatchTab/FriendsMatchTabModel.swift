//
//  FriendsMatchTabModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/11.
//

import Foundation

import RxSwift

struct FriendsMatchTabModel {
    
    let network = FriendsMatchNetwork()
    
    func loadFriendsMatchList() -> Single<Result<[PostListResponseEntity], WanfError>> {
        return network.getAllPosts()
    }
    
    func getFriendsMatchListValue(_ result: Result<[PostListResponseEntity], WanfError>) -> [PostListResponseEntity]? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    func getFriendsMatchListError(_ result: Result<[PostListResponseEntity], WanfError>) -> Void? {
        guard case .failure(let error) = result else {
            return nil
        }
        let errorDescription = (error as NSError)
        print("ERROR: \(errorDescription.code) \(errorDescription.localizedDescription)")
        return Void()
    }
    
}
