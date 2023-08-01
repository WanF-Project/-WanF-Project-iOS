//
//  SlicePostPaginationResponseEntity.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/01.
//

import Foundation

struct SlicePostPaginationResponseEntity: Decodable {
    let content: [PostListResponseEntity]
    
    let size: Int
    let number: Int
    let numberOfElements: Int
    let last: Bool
    let first: Bool
}
