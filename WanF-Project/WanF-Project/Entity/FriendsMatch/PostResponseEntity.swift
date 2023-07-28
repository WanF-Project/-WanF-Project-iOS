//
//  PostResponseEntity.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/18.
//

import Foundation

struct PostResponseEntity: Decodable {
    let id: Int
    let date: String
    let title: String
    let content: String

    let profile: ProfileResponseEntity
    let lectureInfo: CourseEntity
    let comments: [CommentResponseEntity]
    
    enum CodingKeys: String, CodingKey {
        case id, title, content, profile, comments
        case date = "createdDate"
        case lectureInfo = "course"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.date = try container.decode(String.self, forKey: .date)
        self.title = try container.decode(String.self, forKey: .title)
        self.content = try container.decode(String.self, forKey: .content)
        
        self.profile = try container.decode(ProfileResponseEntity.self, forKey: .profile)
        self.lectureInfo = try container.decode(CourseEntity.self, forKey: .lectureInfo)
        self.comments = try container.decode([CommentResponseEntity].self, forKey: .comments)
    }
}
