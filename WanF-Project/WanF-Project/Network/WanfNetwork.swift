//
//  WanfNetwork.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/06.
//

import Foundation

enum WanfError: Error {
    case invalidURL
    case invalidJSON
    case networkError
    case apiKeyError
}

class WanfNetwork {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}
