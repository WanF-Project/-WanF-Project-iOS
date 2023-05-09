//
//  WanfAPI.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/06.
//

import Foundation

class WanfAPI {
    let scheme: String
    let host: String
    
    init(
        scheme: String = "https",
        host: String = "wanf-general-server.duckdns.org"
    ) {
        self.scheme = scheme
        self.host = host
    }
}
