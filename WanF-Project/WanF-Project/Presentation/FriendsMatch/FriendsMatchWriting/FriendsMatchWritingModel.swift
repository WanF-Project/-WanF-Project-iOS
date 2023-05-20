//
//  FriendsMatchWritingModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/17.
//

import Foundation

import RxSwift

struct FriendsMatchWritingModel {
    
    //MARK: - Properties
    let network = FriendsMatchNetwork()
    
    //MARK: - Function
    
    // 새로운 글 생성
    func createFriendsMatchDetail(_ data: FriendsMatchWritingEntity) -> Single<Result<Void, WanfError>> {
        return network.createPost(data)
    }
    
    func getSavedFriendsMatchDetailValue(_ result: Result<Void, WanfError>) -> Void? {
        if case .success(let value) = result {
            return value
        }
        return nil
    }
    
    func getSavedFriendsMatchDetailError(_ result: Result<Void, WanfError>) -> Void? {
        if case .failure(let error) = result {
            print("ERROR: \(error)")
            return Void()
        }
        return nil
    }
    
}
