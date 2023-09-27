//
//  ClubPostRequestEntity.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/27.
//

import Foundation

struct ClubPostRequestEntity: Encodable {
    let content: String
    let imageId: Int?
}
