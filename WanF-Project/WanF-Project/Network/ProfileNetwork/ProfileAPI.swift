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
    
    // 나의 프로필 조회
    func getMyProfile() -> URLComponents {
        var components = URLComponents()
        components.scheme = super.scheme
        components.host = super.host
        components.path = self.path
        
        return components
    }
    
    // 나의 프로필 수정
    func patchMyProfile() -> URLComponents {
        var components = URLComponents()
        components.scheme = super.scheme
        components.host = super.host
        components.path = self.path
        
        return components
    }
    
    // 특정 프로필 조회
    func getSpecificProfile(_ id: Int) -> URLComponents {
        var components = URLComponents()
        components.scheme = super.scheme
        components.host = super.host
        components.path = self.path + "/\(id)"
        
        return components
    }
    
    // 목표 리스트 조회
    func getKeyworkGoalList() -> URLComponents {
        var components = URLComponents()
        components.scheme = super.scheme
        components.host = super.host
        components.path = self.path + "/goals"
        
        return components
    }
    
    // 성격 리스트 조회
    func getKeywordPersonalityList() -> URLComponents {
        var components = URLComponents()
        components.scheme = super.scheme
        components.host = super.host
        components.path = self.path + "/personalities"
        
        return components
    }
    
    /// 프로필 생성
    func postCreateProfile() -> URLComponents {
        var components = URLComponents()
        components.scheme = super.scheme
        components.host = super.host
        components.path = self.path
        
        return components
    }
}
