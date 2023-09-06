//
//  MessageDetailModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/06.
//

import Foundation

import RxSwift
import RxCocoa

struct MessageDetailModel {
    
    let network = MessageNetwork()
    
    /// 쪽지 상세 조회
    func loadMessageDetail(_ id: Int) -> Single<Result<ReceiverMessageResponseEntity, WanfError>> {
        return network.getLoadMessageDetail(id)
    }
    
    func loadMessageDetailValue(_ result: Result<ReceiverMessageResponseEntity, WanfError>) -> ReceiverMessageResponseEntity? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    func loadMessageDetailError(_ result: Result<ReceiverMessageResponseEntity, WanfError>) -> WanfError? {
        guard case .failure(let error) = result else {
            return nil
        }
        return error
    }
}
