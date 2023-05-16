//
//  FriendsMatchCommentEntity.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/16.
//

import Foundation

struct FriendsMatchCommentEntity {
    let id: Int
    let content: String
    let profile: ProfileContent
}

extension FriendsMatchCommentEntity {
    static let comments = [
        FriendsMatchCommentEntity(id: 0, content: "내용0", profile: ProfileContent(profileImage: "BEAR", nickname: "별명1", major: "전공1", entranceYear: "2023", birth: "23", gender: "남자", MBTI: "MBTI", personality: ["성경"], purpose: ["목적"], contact: "연락처"))
    ]
}
