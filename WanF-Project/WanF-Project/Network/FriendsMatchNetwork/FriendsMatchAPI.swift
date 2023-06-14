//
//  FriendsMatchAPI.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/13.
//

import Foundation

class FriendsMatchAPI: WanfAPI {
    
    //MARK: - Properties
    let path = "/api/v1/posts"
    let category = URLQueryItem(name: "category", value: "friend")
    
    init() {
        super.init()
    }
    
    //MARK: - Function
    
    // 전체 게시글 조회
    func getAllPosts() -> URLComponents {
        var components = URLComponents()
        components.scheme = super.scheme
        components.host = super.host
        components.path = self.path
        components.queryItems = [self.category]
        
        return components
    }
    
    // 게시글 생성
    func createPost() -> URLComponents {
        var components = URLComponents()
        components.scheme = super.scheme
        components.host = super.host
        components.path = self.path
        components.queryItems = [self.category]
        
        return components
    }
    
    // 특정 게시글 조회
    func getPostDetail(_ id: Int) -> URLComponents {
        var components = URLComponents()
        components.scheme = super.scheme
        components.host = super.host
        components.path = self.path + "/\(id)"
        
        return components
    }
    
    // 게시글 삭제
    func deletePostDetail(_ id: Int) -> URLComponents {
        var components = URLComponents()
        components.scheme = super.scheme
        components.host = super.host
        components.path = self.path + "/\(id)"
        
        return components
    }
    
    // 댓글 작성
    func postComment(_ postId: Int) -> URLComponents {
        var components = URLComponents()
        components.scheme = super.scheme
        components.host = super.host
        components.path = self.path + "/\(postId)/comments"
        
        return components
    }
}
