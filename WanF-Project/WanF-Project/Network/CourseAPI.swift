//
//  CourseAPI.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/19.
//

import Foundation

class CourseAPI: WanfAPI {
    
    let path = "/api/v1/courses"
    
    init() {
        super.init()
    }
    
    // 모든 강의 조회
    func getAllCourses() -> URLComponents {
        var components = URLComponents()
        components.scheme = super.scheme
        components.host = super.host
        components.path = self.path
        
        return components
    }
    
}
