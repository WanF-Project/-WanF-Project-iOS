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
    
    func saveProfileKeywordList (_ data: [String], profile: ProfileContent, type: ProfileKeywordType) -> Single<Result<Void, WanfError>> {
        guard let personality = (profile.personality as NSDictionary).allKeys as? Array<String>,
              let purpose = (profile.purpose as NSDictionary).allKeys as? Array<String> else
        { return .just(.failure(.invalidJSON)) }
        
        switch type {
        case .personality:
            let profileWriting = ProfileContentWritingEntity(profileImage: profile.profileImage, nickname: profile.nickname, majorId: profile.major?.id, entranceYear: profile.entranceYear, birth: profile.birth, gender: profile.gender?.keys.first, mbti: profile.mbti, personality: data, purpose: purpose, contact: profile.contact)
            return patchProfile(profileWriting)
        case .purpose:
            let profileWriting = ProfileContentWritingEntity(profileImage: profile.profileImage, nickname: profile.nickname, majorId: profile.major?.id, entranceYear: profile.entranceYear, birth: profile.birth, gender: profile.gender?.keys.first, mbti: profile.mbti, personality: personality, purpose: data, contact: profile.contact)
            return patchProfile(profileWriting)
        }
    }
    
    func patchProfile(_ profile: ProfileContentWritingEntity) -> Single<Result<Void, WanfError>> {
        return network.patchMyProfile(profile)
    }
    
    func getPatchProfileValue(_ result: Result<Void, WanfError>) -> Void? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    func getPatchProfileError(_ result: Result<Void, WanfError>) -> Void? {
        guard case .failure(let error) = result else {
            return nil
        }
        print("ERROR: \(error)")
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

