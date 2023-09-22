//
//  ClubPostResponseEntity.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/22.
//

import Foundation

struct ClubPostResponseEntity: Decodable {
    let id: Int
    let createdDate: String
    let nickname: String
    let content: String
    let image: ImageResponseEntity?
}

typealias ClubPostListResponseEntity = [ClubPostResponseEntity]
