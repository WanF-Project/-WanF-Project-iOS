//
//  ReceiverMessageResponseEntity.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/06.
//

import Foundation

struct ReceiverMessageResponseEntity: Decodable {
    let myProfileId: Int
    let messages: [MessageResponseEntity]
}

struct MessageResponseEntity: Decodable {
    let senderProfileId: Int
    let content: String
    let createDate: String
    let modifiedDate: String
}
