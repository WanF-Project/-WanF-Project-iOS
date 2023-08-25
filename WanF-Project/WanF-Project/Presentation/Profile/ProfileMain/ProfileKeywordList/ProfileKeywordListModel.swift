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
}

//MARK: - Function of Each Keyword Type
private extension ProfileKeywordListModel {
    
    func getPersonalityList() -> Single<Result<KeywordEntity, WanfError>> {
        return network.getKeywordPersonalityList()
    }
    
    func getPurposeList() -> Single<Result<KeywordEntity, WanfError>> {
        return network.getKeywordGoalList()
    }
}

enum ProfileKeywordType {
    case personality
    case purpose
}

