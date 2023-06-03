//
//  MajorAPI.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/30.
//

import Foundation

class MajorAPI: WanfAPI {
    
    let path = "/api/v1/majors"
    
    init() {
        super.init()
    }
    
    // 모든 전공 조회
    func getAllMajors() -> URLComponents {
        var components = URLComponents()
        components.scheme = super.scheme
        components.host = super.host
        components.path = self.path
        
        return components
    }
}
