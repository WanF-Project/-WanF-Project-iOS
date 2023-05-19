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
    
    init(_ key: String) {
        self.key = key
    }
    
    var wrappedValue: String? {
        get {
            let resultObservable = AuthNetwork().checkAuthorizationExpired()
            var returnedValue: String?
            
            resultObservable
                .asObservable()
                .subscribe { result in
                    if case .success(let value) = result {
                        returnedValue = value
                        return Void()
                    }
                    returnedValue = nil
                    return Void()
                }
                .disposed(by: DisposeBag())
            
            return returnedValue
        }
        
        set {
            // None
        }
    }
    
}
