//
//  FriendsMatchListCellModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/11.
//

import Foundation

struct FriendsMatchListCellModel: Decodable {
    let id: Int
    let title: String
    let lectureInfo: LectureInfEntity
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case lectureInfo = "course"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.lectureInfo = try container.decode(LectureInfEntity.self, forKey: .lectureInfo)
    }
}
