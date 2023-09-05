//
//  MessageEntity.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/04.
//

import Foundation

import MessageKit

struct MessageEntity: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    let content: String
    var kind: MessageKind {
        .text(content)
    }
}

struct SenderEntity: SenderType {
    var senderId: String
    var displayName: String
}
