//
//  MessageRequestEntity.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/09.
//

import Foundation

struct MessageRequestEntity: Encodable {
    let receiverProfileId: Int
    let content: String
}
