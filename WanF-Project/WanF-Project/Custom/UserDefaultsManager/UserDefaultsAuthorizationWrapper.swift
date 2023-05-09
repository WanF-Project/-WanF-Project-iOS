//
//  UserDefaultsAuthorizationWrapper.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/09.
//

import Foundation

@propertyWrapper
struct UserDefaultsAuthorizationWrapper {
    
    private let key: String
    
    init(_ key: String) {
        self.key = key
    }
    
    var wrappedValue: String? {
        get {
            return UserDefaults.standard.string(forKey: key)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
