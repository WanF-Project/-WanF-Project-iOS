//
//  ProfileRequestEntity.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/30.
//

import Foundation

struct ProfileRequestEntity: Encodable {
    let profileImage: String?
    let nickname: String?
    let majorId: Int?
    let entranceYear: Int
    let birth: Int
    let gender: String?
    let mbti: String?
    let personality: [String]
    let purpose: [String]
    let contact: String?
    
    enum CodingKeys: String, CodingKey {
        case profileImage, nickname, majorId, gender, mbti, contact
        case entranceYear = "studentId"
        case birth = "age"
        case personality = "personalities"
        case purpose = "goals"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.profileImage, forKey: .profileImage)
        try container.encode(self.nickname, forKey: .nickname)
        try container.encode(self.majorId, forKey: .majorId)
        try container.encode(self.gender, forKey: .gender)
        try container.encode(self.mbti, forKey: .mbti)
        try container.encode(self.contact, forKey: .contact)
        try container.encode(self.entranceYear, forKey: .entranceYear)
        try container.encode(self.birth, forKey: .birth)
        try container.encode(self.personality, forKey: .personality)
        try container.encode(self.purpose, forKey: .purpose)
    }
}
