//
//  RandomAPI.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/14.
//

import Foundation

class RandomAPI: WanfAPI {
    
    let path = "/api/v1/profiles/random"
    
    /// 랜덤 프로필 조회
    func getRandomProfiles(_ pageable: PageableEntity) -> URLComponents {
        let queryItems = [
            URLQueryItem(name: "page", value: pageable.page.description),
            URLQueryItem(name: "size", value: pageable.size.description),
            URLQueryItem(name: "sort", value: pageable.sort.description)
        ]
        
        var components = URLComponents()
        components.scheme = super.scheme
        components.host = super.host
        components.path = path
        components.queryItems = queryItems
        
        return components
    }
}
