//
//  FriendsMatchWritingModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/17.
//

import Foundation

import RxSwift

// TODO: - 서버 연결 시 재구현
struct FriendsMatchWritingModel {
    
    func saveFriendsMatchDetail(_ data: FriendsMatchDetail) -> Observable<Bool> {
        return Observable
            .just(data)
            .map {
                print($0)
                return true
            }
    }
    
    func getSavedFriendsMatchDetailValue(_ result: Bool) -> Bool? {
        if !result {
            return nil
        }
        return true
    }
    
    func getSavedFriendsMatchDetailError(_ result: Bool) -> Bool? {
        if result {
            return nil
        }
        return false
    }
    
}
