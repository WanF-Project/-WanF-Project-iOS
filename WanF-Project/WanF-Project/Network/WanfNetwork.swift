//
//  WanfNetwork.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/06.
//

import Foundation

enum WanfError {
    case invalidURL
    case invalidJSON
    case networkError
    case apiKeyError
}

class WanfNetwork {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}
