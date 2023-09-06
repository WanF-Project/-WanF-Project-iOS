//
//  MessageListModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/06.
//

import Foundation

import RxSwift
import RxCocoa

struct MessageListModel {
    
    let network = MessageNetwork()
    
    /// 쪽지 목록 조회
    func loadMessageList() -> Single<Result<MessageListResponseEntity, WanfError>> {
        return network.getLoadMessageList()
    }
    
    func loadMessageListValue(_ result: Result<MessageListResponseEntity, WanfError>) -> MessageListResponseEntity? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    func loadMessageListError(_ result: Result<MessageListResponseEntity, WanfError>) -> WanfError? {
        guard case .failure(let error) = result else {
            return nil
        }
        return error
    }
}
