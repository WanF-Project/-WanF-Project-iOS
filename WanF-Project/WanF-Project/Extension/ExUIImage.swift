//
//  ExUIImage.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/22.
//

import UIKit

enum ImageContentType: String {
    case jpeg = "image/jpeg"
    case png = "image/png"
}

extension UIImage {
    /// UIImage의 파일 타입 반환
    var contentType: ImageContentType? {
        guard let utType = self.cgImage?.utType as? String,
              let type = utType.components(separatedBy: ".").last else { return nil }
        
        switch type {
        case "jpeg":
            return .jpeg
        case "png":
            return .png
        default:
            return nil
        }
    }
}

