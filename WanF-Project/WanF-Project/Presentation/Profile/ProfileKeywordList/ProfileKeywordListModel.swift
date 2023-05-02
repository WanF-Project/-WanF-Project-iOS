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
    
    func getProfileKeywordList(_ type: ProfileKeywordType) -> Observable<[String]> {
        switch type {
        case .personality:
            return getPersonalityList()
        case .purpose:
            return getPurposeList()
        }
    }
    
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
}

//MARK: - Function of Each Keyword Type
private extension ProfileKeywordListModel {
    
    func getPersonalityList() -> Observable<[String]> {
        return Observable
            .of(["성격1", "성격2", "성격3", "성격4"])
    }
    
    func getPurposeList() -> Observable<[String]> {
        return Observable
            .of(["목표1", "목표2", "목표3", "목표4"])
    }
    
    func savePersonality(_ data: [String]) -> Observable<Bool> {
        return Observable
            .just(data)
            .map {
                print($0)
                return true
            }
    }
    
    func savePurpose(_ data: [String]) -> Observable<Bool> {
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

