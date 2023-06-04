//
//  ProfileSingleSelectionListModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/06.
//

import Foundation

import RxSwift

struct ProfileSingleSelectionListModel {
    
    let majorNetwork = MajorNetwork()
    let profileNetwork = ProfileNetwork()
    
    // 전공/MBTI 목록 조회
    func getProfileSingleSelectionList(_ type: ProfileSingleSelectionType) -> Single<Result<[MajorEntity], WanfError>> {
        switch type {
        case .major:
            return getMajorList()
        case .MBTI:
            return getMBTIList()
        }
    }
    
    func getProfileSingleSelectionListValue(_ result: Result<[MajorEntity], WanfError>) -> [MajorEntity]? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    func getProfileSingleSelectionListError(_ result: Result<[MajorEntity], WanfError>) -> Void? {
        guard case .failure(let error) = result else {
            return nil
        }
        print("ERROR: \(error)")
        return Void()
    }
    
    // 프로필 수정
    func saveProfileSingleSelectionList (_ single: MajorEntity, profile: ProfileContent, type: ProfileSingleSelectionType) -> Single<Result<Void, WanfError>> {
        guard let personality = (profile.personality as NSDictionary).allKeys as? Array<String>,
              let purpose = (profile.purpose as NSDictionary).allKeys as? Array<String> else
        { return .just(.failure(.invalidJSON)) }
        
        switch type {
        case .major:
            let majorId = single.id
            let profileWriting = ProfileContentWritingEntity(profileImage: profile.profileImage, nickname: profile.nickname, majorId: majorId, entranceYear: profile.entranceYear, birth: profile.birth, gender: profile.gender?.keys.first, mbti: profile.mbti, personality: personality, purpose: purpose, contact: profile.contact)
            return saveMajor(profileWriting)
        case .MBTI:
            let mbti = single.name ?? "MBTI"
            let profileWriting = ProfileContentWritingEntity(profileImage: profile.profileImage, nickname: profile.nickname, majorId: profile.major?.id, entranceYear: profile.entranceYear, birth: profile.birth, gender: profile.gender?.keys.first, mbti: mbti, personality: personality, purpose: purpose, contact: profile.contact)
            return saveMBTI(profileWriting)
        }
    }
    
    func getSavedProfileSingleSelectionListValue(_ result: Result<Void, WanfError>) -> Void? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    func getSavedProfileSingleSelectionListError(_ result: Result<Void, WanfError>) -> Void? {
        guard case .failure(let error) = result else {
            return nil
        }
        print("ERROR: \(error)")
        return Void()
    }
}

//MARK: - Function of Each Type
private extension ProfileSingleSelectionListModel {
    
    func getMajorList() -> Single<Result<[MajorEntity], WanfError>> {
        return majorNetwork.getAllMajors()
    }
    
    func getMBTIList() -> Single<Result<[MajorEntity], WanfError>> {
        
        if let url = Bundle.main.url(forResource: "WanF", withExtension: "plist") {
            let dictionary = NSDictionary(contentsOf: url)
            let items = dictionary?["MBTI"] as? Array<String> ?? []
            var mbtiList: [MajorEntity] = []
            
            for id in 0 ..< items.count {
                mbtiList.append(MajorEntity(id: id, name: items[id]))
            }
            
            return .just(.success(mbtiList))
        }
        else {
            return .just(.failure(.networkError))
        }
    }
    
    // 프로필 수정
    func saveMajor(_ data: ProfileContentWritingEntity) -> Single<Result<Void, WanfError>> {
        return profileNetwork.patchMyProfile(data)
    }
    
    func saveMBTI(_ data: ProfileContentWritingEntity) -> Single<Result<Void, WanfError>> {
        return .just(.success(Void()))
    }
}

//MARK: - Type
enum ProfileSingleSelectionType {
    case major
    case MBTI
}
