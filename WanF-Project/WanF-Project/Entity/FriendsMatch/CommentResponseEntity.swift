//
//  CommentResponseEntity.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/16.
//

import Foundation

struct CommentResponseEntity: Decodable {
    let id: Int
    let content: String
    let profile: ProfileResponseEntity
}
