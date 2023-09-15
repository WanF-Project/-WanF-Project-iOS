//
//  PageableEntity.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/01.
//

import Foundation

struct PageableEntity: Encodable {
    var page: Int
    let size: Int
    let sort: [Sort]
    
    enum Sort: String, Encodable {
        case empty = ""
        case latest = "modifiedDate,DESC"
    }
}
