//
//  ClubAPI.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/17.
//

import Foundation

class ClubAPI: WanfAPI {
    
    private let path = "/api/v1/clubs"
    
    init() {
        super.init()
    }
    
    /// 모든 모임 조회
    func getAllClubs() -> URLComponents {
        var components = URLComponents()
        components.scheme = super.scheme
        components.host = super.host
        components.path = self.path
        
        return components
    }
    
    /// 모임 비밀번호 조회
    func getClubPassword(_ clubID: Int) -> URLComponents {
        var components = URLComponents()
        components.scheme = super.scheme
        components.host = super.host
        components.path = self.path + "/\(clubID)/password"
        
        return components
    }
    
    /// 모임 생성
    func postCreateClub() -> URLComponents {
        var components = URLComponents()
        components.scheme = super.scheme
        components.host = super.host
        components.path = self.path
        
        return components
    }
    
    /// 모임 가입
    func postJoinClub(_ club: ClubPwdRequestEntity) -> URLComponents {
        var components = URLComponents()
        components.scheme = super.scheme
        components.host = super.host
        components.path = self.path + "/join"
        
        return components
    }
    
    /// 모임 상세 전체 게시글 조회
    func getAllClubPosts(_ clubId: Int) -> URLComponents {
        var components = URLComponents()
        components.scheme = super.scheme
        components.host = super.host
        components.path = self.path + "/\(clubId)/clubposts"
        
        return components
    }
    
    /// 모임 상세 게시글 생성
    func postClubPost(_ clubId: Int) -> URLComponents {
        var components = URLComponents()
        components.scheme = super.scheme
        components.host = super.host
        components.path = self.path + "/\(clubId)/clubposts"
        
        return components
    }
}
