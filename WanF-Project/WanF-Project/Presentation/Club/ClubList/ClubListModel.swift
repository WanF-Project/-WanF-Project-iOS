//
//  ClubListModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/17.
//

import Foundation

import RxSwift
import RxCocoa

struct ClubListModel {
    let network = ClubNetwork()
    
    /// 모든 모임 조회
    func getAllClubs() -> Single<Result<[ClubResponseEntity], WanfError>> {
        return network.getAllClubs()
    }
    
    /// 모든 모임 조회 - 성공
    func getAllClubsValue(_ result: Result<[ClubResponseEntity], WanfError>) -> [ClubResponseEntity]? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    /// 모든 모임 조회 - 실패
    func getAllClubsError(_ result: Result<[ClubResponseEntity], WanfError>) -> Void? {
        guard case .failure(let error) = result else {
            return nil
        }
        return Void()
    }
}
