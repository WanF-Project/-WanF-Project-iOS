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
    func loadDetail(_ id: Int) -> Single<Result<PostResponseEntity, WanfError>> {
        return network.getPostDetail(id)
    }
    
    func getDetailValue(_ result: Result<PostResponseEntity, WanfError>) -> PostResponseEntity? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    func getDetailError(_ result: Result<PostResponseEntity, WanfError>) -> Void? {
        guard case .failure(let error) = result else {
            return nil
        }
        print("ERROR: \(error)")
        return Void()
    }
    
    // Delete Detail
    func deleteDetail(_ id: Int) -> Single<Result<Void, WanfError>> {
        return network.deletePostDetail(id)
    }
    
    func getDeleteDetailValue(_ result: Result<Void, WanfError>) -> Void? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    func getDeleteDetailError(_ result: Result<Void, WanfError>) -> Void? {
        guard case .failure(let error) = result else {
            return nil
        }
        print("ERROR: \(error)")
        return Void()
    }
    
    // Save the Comment
    func postComment(_ postId: Int, content: CommentRequestEntity) -> Single<Result<Void, WanfError>> {
        return network.postComment(postId, content: content)
    }
    
    func postCommentValue(_ result: Result<Void, WanfError>) -> Void? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    func postCommentError(_ result: Result<Void, WanfError>) -> Void? {
        guard case .failure(let error) = result else {
            return nil
        }
        print("ERROR: \(error)")
        return Void()
    }
    
}
