//
//  ClubRequestEntity.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/22.
//

import Foundation

struct ClubRequestEntity: Encodable {
    let name: String
    let maxParticipants: Int
    let password: String
}
