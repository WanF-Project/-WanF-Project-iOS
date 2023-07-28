//
//  PostRequestEntity.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/17.
//

import Foundation

struct PostRequestEntity: Encodable {
    let title: String
    let content: String
    let lectureID: Int
    
    enum CodingKeys: String, CodingKey {
        case title, content
        case lectureID = "courseId"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(title, forKey: .title)
        try? container.encode(content, forKey: .content)
        try? container.encode(lectureID, forKey: .lectureID)
        
    }
}


