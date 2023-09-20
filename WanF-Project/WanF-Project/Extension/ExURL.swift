//
//  ExURL.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/20.
//

import UIKit

extension URL {
    
    /// URL을 UIImage로 변환하여 제공하는 메서드
    public func image(_ completionHandler: @escaping (UIImage) -> Void) {
        URLSession.shared.dataTask(with: self) { data, _, error in
            if let error = error {
                debugPrint("ERROR: \(error)")
            }
            
            guard let data = data,
                  let image = UIImage(data: data) else { return }
            
            completionHandler(image)
        }.resume()
    }
}
