//
//  ProfileImageRequestEntity.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/21.
//

import Foundation

struct ProfileImageRequestEntity: Encodable {
    let imageId: Int?
    let profileRequest: ProfileRequestEntity
}
