//
//  ProfileContent.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/29.
//

import Foundation

struct ProfileContent: Decodable {
    let id: Int
    let profileImage: String?
    let nickname: String?
    let entranceYear: Int
    let birth: Int
    let gender: KeywordEntity?
    let mbti: String?
    let personality: KeywordEntity
    let purpose: KeywordEntity
    let contact: String? 
    
    let major: MajorEntiry?
    
    enum CodingKeys: String, CodingKey {
        case id, profileImage, nickname, major, gender, mbti, contact
        case entranceYear = "studentId"
        case birth = "age"
        case personality = "personalities"
        case purpose = "goals"
    }
    
    init(id: Int, image profileImage: String, nickname: String, entranceYear: Int, birth: Int, gender: KeywordEntity, mbti: String, personality: KeywordEntity, purpose: KeywordEntity, contact: String, major: MajorEntiry) {
        
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
        self.profileImage = try container.decode(String?.self, forKey: .profileImage)
        self.nickname = try container.decode(String?.self, forKey: .nickname)
        self.major = try container.decode(MajorEntiry?.self, forKey: .major)
        self.gender = try container.decode(KeywordEntity?.self, forKey: .gender)
        self.mbti = try container.decode(String?.self, forKey: .mbti)
        self.contact = try container.decode(String?.self, forKey: .contact)
        self.entranceYear = try container.decode(Int.self, forKey: .entranceYear)
        self.birth = try container.decode(Int.self, forKey: .birth)
        self.personality = try container.decode(KeywordEntity.self, forKey: .personality)
        self.purpose = try container.decode(KeywordEntity.self, forKey: .purpose)
    }
}

struct MajorEntiry: Codable {
    let id: Int
    let name: String?
}

typealias KeywordEntity = Dictionary<String, String>
