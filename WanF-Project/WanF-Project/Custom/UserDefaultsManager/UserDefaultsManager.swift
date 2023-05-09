//
//  UserDefaultsManager.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/09.
//

import Foundation

struct UserDefaultsManager {
    @UserDefaultsAuthorizationWrapper("AccessToken")
    static var accessToken: String?
    
    @UserDefaultsAuthorizationWrapper("RefreshToken")
    static var refreshToken: String?
}
