//
//  ProfileRequestEntity.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/30.
//

import Foundation

struct ProfileRequestEntity: Encodable {
    let nickname: String
    let majorId: Int
    let studentId: Int
    let age: Int
    let gender: String
    let mbti: String
    let personalities: [String]
    let goals: [String]
}
