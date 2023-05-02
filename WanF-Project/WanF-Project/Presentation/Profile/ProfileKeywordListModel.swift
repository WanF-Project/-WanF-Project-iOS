//
//  ProfileKeywordListModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/02.
//

import Foundation

import RxSwift

// TODO: - 서버 연결 시 재구현
struct ProfileKeywordListModel {
    
    func saveProfileKeywordList (_ data: [String], type: ProfileKeywordType) -> Observable<Bool> {
        switch type {
        case .personality:
            return savePersonality(data)
        case .purpose:
            return savePurpose(data)
        }
        
        
    }
    
    func getSavedProfileKeywordListValue(_ result: Bool) -> Bool? {
        if !result {
            return nil
        }
        return true
    }
    
    func getSavedProfileKeywordListError(_ result: Bool) -> Bool? {
        if result {
            return nil
        }
        return false
    }
    
    private func savePersonality(_ data: [String]) -> Observable<Bool> {
        return Observable
            .just(data)
            .map {
                print($0)
                return true
            }
    }
    
    private func savePurpose(_ data: [String]) -> Observable<Bool> {
        return Observable
            .just(data)
            .map {
                print($0)
                return true
            }
    }
}

enum ProfileKeywordType {
    case personality
    case purpose
}

