//
//  ProfileCreateModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/21.
//

import Foundation

import RxSwift

struct ProfileCreateModel {
    let imageNetwork = ImageNetwork()
    
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
    
    func uploadImageError(_ result: Result<ImageResponseEntity, WanfError>) -> Void? {
        guard case .failure(let error) = result else {
            return nil
        }
        print("ERROR: \(error)")
        return Void()
    }
}

