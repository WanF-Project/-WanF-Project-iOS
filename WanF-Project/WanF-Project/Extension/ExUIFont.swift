//
//  ExUIFont.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/01.
//

import UIKit

extension UIFont {
    
    //MARK: - WanF Font
    
    enum WanfWeight: String {
        case light = "NanumSquareNeoTTF-aLt"
        case regular = "NanumSquareNeoTTF-bRg"
        case bold = "NanumSquareNeoTTF-cBd"
        case extraBold = "NanumSquareNeoTTF-dEb"
        case heavy = "NanumSquareNeoTTF-eHv"
    }
    
    static func wanfFont(ofSize size: CGFloat, weight: UIFont.WanfWeight) -> UIFont {
        let font = UIFont(name: weight.rawValue, size: size)
        
        return font ?? systemFont(ofSize: size, weight: .regular)
    }
    
}
