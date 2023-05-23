//
//  ProfileContent.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/29.
//

import Foundation

struct ProfileContent: Codable {
    let id: Int
    let profileImage: String
    let nickname: String
    let entranceYear: String
    let birth: String
    let gender: String
    let mbti: String
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
    
    enum CodingKeys: String, CodingKey {
        case id, profileImage, nickname, major, gender, mbti, contact
        case entranceYear = "studentId"
        case birth = "age"
        case personality = "personalities"
        case purpose = "goals"
    }
    
    init(id: Int, image profileImage: String, nickname: String, entranceYear: String, birth: String, gender: String, mbti: String, personality: [String], purpose: [String], contact: String, major: MajorEntiry) {
        
        self.id = id
        self.profileImage = profileImage
        self.nickname = nickname
        self.entranceYear = entranceYear
        self.birth = birth
        self.gender = gender
        self.mbti = mbti
        self.personality = personality
        self.purpose = purpose
        self.contact = contact
        self.major = major
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.profileImage = try container.decode(String.self, forKey: .profileImage)
        self.nickname = try container.decode(String.self, forKey: .nickname)
        self.major = try container.decode(MajorEntiry.self, forKey: .major)
        self.gender = try container.decode(String.self, forKey: .gender)
        self.mbti = try container.decode(String.self, forKey: .mbti)
        self.contact = try container.decode(String.self, forKey: .contact)
        self.entranceYear = try container.decode(String.self, forKey: .entranceYear)
        self.birth = try container.decode(String.self, forKey: .birth)
        self.personality = try container.decode([String].self, forKey: .personality)
        self.purpose = try container.decode([String].self, forKey: .purpose)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.id, forKey: .id)
        try container.encode(self.profileImage, forKey: .profileImage)
        try container.encode(self.nickname, forKey: .nickname)
        try container.encode(self.major, forKey: .major)
        try container.encode(self.gender, forKey: .gender)
        try container.encode(self.mbti, forKey: .mbti)
        try container.encode(self.contact, forKey: .contact)
        try container.encode(self.entranceYear, forKey: .entranceYear)
        try container.encode(self.birth, forKey: .birth)
        try container.encode(self.personality, forKey: .personality)
        try container.encode(self.purpose, forKey: .purpose)
    }
}

struct MajorEntiry: Codable {
    let id: Int
    let name: String
}
