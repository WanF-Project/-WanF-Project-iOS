//
//  ProfileKeywordListModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/02.
//

import Foundation

import RxSwift

struct ProfileKeywordListModel {
    
    let network = ProfileNetwork()
    
    func getProfileKeywordList(_ type: ProfileKeywordType) -> Single<Result<KeywordEntity, WanfError>> {
        switch type {
        case .personality:
            return getPersonalityList()
        case .purpose:
            return getPurposeList()
        }
    }
    
    func getProfileKeywordListValue(_ result: Result<KeywordEntity, WanfError>) -> KeywordEntity? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    func getProfileKeywordListError(_ result: Result<KeywordEntity, WanfError>) -> Void? {
        guard case .failure(let error) = result else{
            return nil
        }
        print("EEROR: \(error)")
        return Void()
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
    
    func getPersonalityList() -> Single<Result<KeywordEntity, WanfError>> {
        return network.getKeywordPersonalityList()
    }
    
    func getPurposeList() -> Single<Result<KeywordEntity, WanfError>> {
        return network.getKeywordGoalList()
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

