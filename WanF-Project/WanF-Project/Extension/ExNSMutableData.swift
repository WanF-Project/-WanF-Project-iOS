//
//  ExNSMutableData.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/21.
//

import Foundation

extension NSMutableData {
    /// String을 Data로 변환해 추가합니다
    func appendString(_ str: String) {
        guard let data = str.data(using: .utf8) else { return }
        self.append(data)
    }
}

