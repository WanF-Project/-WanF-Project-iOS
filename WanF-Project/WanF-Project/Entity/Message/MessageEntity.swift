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
    let messageId: String = UUID().uuidString
    var sentDate: Date
    var content: String
    var kind: MessageKind {
        .text(content)
    }
    
    init(sender: SenderType, sentDate: String, content: String) {
        self.sender = sender
        self.sentDate = DateFormatter().date(from: sentDate) ?? Date()
        self.content = content
    }
}

struct SenderEntity: SenderType {
    var senderId: String
    var displayName: String = ""
    
    init(senderId: String) {
        self.senderId = senderId
    }
}
