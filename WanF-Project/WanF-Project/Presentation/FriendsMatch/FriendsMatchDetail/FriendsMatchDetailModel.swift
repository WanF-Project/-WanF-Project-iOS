//
//  FriendsMatchDetailModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/18.
//

import Foundation

import RxSwift

// TODO: - 서버 연결 시 재구현
struct FriendsMatchDetailModel {
    
    func loadDetail() -> Observable<Bool> {
        return Observable
            .just(true)
    }
    
    func getDetailValue(_ result: Bool) -> FriendsMatchDetail? {
        if !result {
            return nil
        }
        return FriendsMatchDetail.detailData
    }
    
    func getDetailError(_ result: Bool) -> Bool? {
        if result {
            return nil
        }
        return false
    }
    
}
