//
//  RandomFriendsModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/14.
//

import Foundation

import RxSwift
import RxCocoa

struct RandomFriendsModel {
    
    private let network = RandomNetwork()
    
    /// 랜덤 프로필 조회
    func loadRandomFriends(_ pageable: PageableEntity) -> Single<Result<SlicePageableResponseEntity<ProfileResponseEntity>, WanfError>> {
        return network.getRandomProfiles(pageable)
    }
    
    func loadRandomFriendsValue(_ result: Result<SlicePageableResponseEntity<ProfileResponseEntity>, WanfError>) -> SlicePageableResponseEntity<ProfileResponseEntity>? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    func loadRandomFriendsError(_ result: Result<SlicePageableResponseEntity<ProfileResponseEntity>, WanfError>) -> WanfError? {
        guard case .failure(let error) = result else {
            return nil
        }
        return error
    }
}
