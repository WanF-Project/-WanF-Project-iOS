//
//  BannerResponseEntity.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/10/26.
//

import Foundation

typealias BannerResponseEntity = [BannerEntity]

struct BannerEntity: Decodable {
    let url: String
    let image: ImageResponseEntity
}
