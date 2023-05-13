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
    
}
