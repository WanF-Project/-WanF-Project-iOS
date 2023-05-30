//
//  ProfileContentModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/29.
//

import Foundation

import RxSwift

struct ProfileContentModel {
    
    let network = ProfileNetwork()
    
    // 나의 프로필 조회
    func loadProfile() -> Single<Result<ProfileContent, WanfError>> {
        return network.getMyProfile()
    }
    
    func getProfileValue(_ result: Result<ProfileContent, WanfError>) -> ProfileContent? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    func getProfileError(_ result: Result<ProfileContent, WanfError>) -> Void? {
        guard case .failure(let error) = result else {
            return nil
        }
        print("ERROR: \(error)")
        return Void()
    }
    
    // 나의 프로필 수정
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
