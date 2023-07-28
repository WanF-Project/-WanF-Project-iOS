//
//  LectureInfEntity.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/11.
//

import Foundation

struct CourseEntity: Decodable {
    let id: Int
    let lectureName: String
    let professorName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case lectureName = "name"
        case professorName = "professor"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.lectureName = try container.decode(String.self, forKey: .lectureName)
        self.professorName = try container.decode(String.self, forKey: .professorName)
    }
}
