//
//  ProfileAPI.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/28.
//

import Foundation

class ProfilAPI: WanfAPI {
    
    let path = "/api/v1/profiles"
    
    init() {
        super.init()
    }
    
    // 목표 리스트 조회
    func getKeyworkGoalList() -> URLComponents {
        var components = URLComponents()
        components.scheme = super.scheme
        components.host = super.host
        components.path = self.path + "/goals"
        
        return components
    }
}
