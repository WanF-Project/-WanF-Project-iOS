//
//  BannerAPI.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/10/29.
//

import Foundation

class BannerAPI: WanfAPI {
    
    private let path = "/api/v1/banners"
    
    init() {
        super.init()
    }
    
    /// 배너 조회
    func getBanners() -> URLComponents {
        var components = URLComponents()
        components.scheme = super.scheme
        components.host = super.host
        components.path = path
        
        return components
    }
    
}
