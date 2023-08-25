//
//  ImageAPI.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/21.
//

import Foundation

enum Directoty: String {
    case profiles = "profiles"
    case posts = "posts"
}

class ImageAPI: WanfAPI {
    
    let path = "/api/v1/images"
    
    init() {
        super.init()
    }
    
    /// 이미지 업로드
    func postUploadImage(directory: Directoty) -> URLComponents {
        let queryItems = [URLQueryItem(name: "directory", value: directory.rawValue)]
        var components = URLComponents()
        components.scheme = super.scheme
        components.host = super.host
        components.path = self.path
        components.queryItems = queryItems
        
        return components
    }
}

