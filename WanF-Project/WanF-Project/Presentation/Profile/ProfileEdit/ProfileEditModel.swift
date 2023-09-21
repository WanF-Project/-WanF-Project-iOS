//
//  ProfileEditModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/21.
//

import Foundation

import RxSwift
import RxCocoa

struct ProfileEditModel {
    let imageNetwork = ImageNetwork()
    let profileNetwork = ProfileNetwork()
    
    /// 이미지 업로드
    func uploadImage(_ image: ImageInfo) -> Single<Result<ImageResponseEntity, WanfError>> {
        return imageNetwork.postUploadImage(image: image, directory: .profiles)
    }

    func uploadImageValue(_ result: Result<ImageResponseEntity, WanfError>) -> ImageResponseEntity? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    func uploadImageError(_ result: Result<ImageResponseEntity, WanfError>) -> WanfError? {
        guard case .failure(let error) = result else {
            return nil
        }
        return error
    }
    
    /// 프로필 수정
    func editProfile(_ profile: ProfileImageRequestEntity) -> Single<Result<ProfileResponseEntity, WanfError>> {
        return profileNetwork.patchMyProfile(profile)
    }

    func editProfileValue(_ result: Result<ProfileResponseEntity, WanfError>) -> ProfileResponseEntity? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    func editProfileError(_ result: Result<ProfileResponseEntity, WanfError>) -> WanfError? {
        guard case .failure(let error) = result else {
            return nil
        }
        return error
    }
}
