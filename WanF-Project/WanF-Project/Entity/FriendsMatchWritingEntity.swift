//
//  FriendsMatchWritingEntity.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/17.
//

import Foundation

struct FriendsMatchWritingEntity: Decodable {
    let title: String
    let content: String
    let lectureID: Int
    
    enum CodingKeys: String, CodingKey {
        case title, content
        case lectureID = "courseId"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.content = try container.decode(String.self, forKey: .content)
        self.lectureID = try container.decode(Int.self, forKey: .lectureID)
    }
    
    init(title: String, content: String, lectureID: Int) {
        self.title = title
        self.content = content
        self.lectureID = lectureID
    }
}


