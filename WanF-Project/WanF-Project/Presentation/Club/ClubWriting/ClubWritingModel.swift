//
//  ClubWritingModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/27.
//

import Foundation

import RxSwift
import RxCocoa

struct ClubWritingModel {
    let imageNetwork = ImageNetwork()
    let clubNetwork = ClubNetwork()
    
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
    
    /// 모임 게시글 생성
    func createClubPost(clubId: Int, post: ClubPostRequestEntity) -> Single<Result<Void, WanfError>> {
        return clubNetwork.postClubPost(clubId, post: post)
    }

    func createClubPostValue(_ result: Result<Void, WanfError>) -> Void? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    func createClubPostError(_ result: Result<Void, WanfError>) -> WanfError? {
        guard case .failure(let error) = result else {
            return nil
        }
        return error
    }
}
