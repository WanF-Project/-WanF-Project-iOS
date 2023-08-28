//
//  ProfileResponseEntity.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/29.
//

import Foundation

struct ProfileResponseEntity: Decodable {
    let id: Int
    let nickname: String
    let major: MajorEntity
    let studentId: Int
    let age: Int
    let gender: KeywordEntity
    let mbti: String
    let personality: KeywordEntity
    let purpose: KeywordEntity
    let image: ImageResponseEntity
}


struct MajorEntity: Nameable, Codable {
    let id: Int
    let name: String
}

struct MbtiEntity: Nameable, Codable {
    let id: Int
    let name: String
}

typealias KeywordEntity = Dictionary<String, String>
