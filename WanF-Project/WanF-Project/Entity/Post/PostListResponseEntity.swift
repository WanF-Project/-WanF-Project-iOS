//
//  PostListResponseEntity.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/11.
//

import Foundation

struct PostListResponseEntity: Decodable {
    let id: Int
    let title: String
    let course: CourseEntity
}
