//
//  FriendsMatchDetailModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/18.
//

import Foundation

import RxSwift

struct FriendsMatchDetailModel {
    
    let network = FriendsMatchNetwork()
    
    // Load Detail
    func loadDetail(_ id: Int) -> Single<Result<FriendsMatchDetailEntity, WanfError>> {
        return network.getPostDetail(id)
    }
    
    func getDetailValue(_ result: Result<FriendsMatchDetailEntity, WanfError>) -> FriendsMatchDetailEntity? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    func getDetailError(_ result: Result<FriendsMatchDetailEntity, WanfError>) -> Void? {
        guard case .failure(let error) = result else {
            return nil
        }
        print("ERROR: \(error)")
        return Void()
    }
    
    // Delete Detail
    func deleteDetail() -> Observable<Bool> {
        return Observable
            .just(true)
    }
    
    func getDeleteDetailValue(_ result: Bool) -> Bool? {
        if !result {
            return nil
        }
        return true
    }
    
    func getDeleteDetailError(_ result: Bool) -> Bool? {
        if result {
            return nil
        }
        return false
    }
    
}
