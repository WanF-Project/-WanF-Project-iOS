//
//  ProfileContent.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/29.
//

import Foundation

struct ProfileContent {
    let profileImage: String
    let nickname: String
    let entranceYear: String
    let birth: String
    let gender: String
    let MBTI: String
    let personality: [String]
    let purpose: [String]
    let contact: String
    
    let major: MajorEntiry
    
    enum Personality: String {
        case personality1 = "느긋함"
        case personality2 = "효율중시"
        case personality3 = "계획적"
        case personality4 = "꼼꼼함"
        case personality5 = "밝음"
        case personality6 = "조용함"
    }
    
    enum Purpose: String {
        case purpose1 = "과탑"
        case purpose2 = "친목"
        case purpose3 = "앞자리"
        case purpose4 = "뒷자리"
        case purpose5 = "평타"
        case purpose6 = "놀자"
    }
}

struct MajorEntiry: Codable {
    let id: Int
    let name: String
}
