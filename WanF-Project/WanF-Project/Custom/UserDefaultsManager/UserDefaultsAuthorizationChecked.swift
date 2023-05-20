//
//  UserDefaultsAuthorizationChecked.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/19.
//

import Foundation

import RxSwift

@propertyWrapper
struct UserDefaultsAuthorizationChecked {
    
    let key: String
    let disposeBag = DisposeBag()
    
    init(_ key: String) {
        self.key = key
    }
    
    var wrappedValue: Observable<String?> {
        get {
            let resultObservable = AuthNetwork().checkAuthorizationExpired()
            
            return resultObservable
                .asObservable()
                .map({ result in
                    if case .success(let value) = result {
                        return value
                    }
                    return nil
                })
        }
        
        set {
            // None
        }
    }
    
}
