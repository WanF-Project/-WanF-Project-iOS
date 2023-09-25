//
//  ClubDetailModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/25.
//

import Foundation

import RxSwift
import RxCocoa

struct ClubDetailModel {
    
    private let network = ClubNetwork()
    
    /// 모임 전체 게시글 조회
    func loadAllClubPosts(_ clubId: Int) -> Single<Result<ClubPostListResponseEntity, WanfError>> {
        return network.getAllClubPosts(clubId)
    }
    
    func loadAllClubPostValue(_ result: Result<ClubPostListResponseEntity, WanfError>) -> ClubPostListResponseEntity? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    func loadAllClubPostError(_ result: Result<ClubPostListResponseEntity, WanfError>) -> WanfError? {
        guard case .failure(let error) = result else {
            return nil
        }
        return error
    }
}
