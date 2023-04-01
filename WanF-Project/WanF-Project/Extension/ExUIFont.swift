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
        case light = "NanumSquareNeo-aLt.ttf"
        case regular = "NanumSquareNeo-bRg.ttf"
        case bold = "NanumSquareNeo-cBd.ttf"
        case extraBold = "NanumSquareNeo-dEb.ttf"
        case heavy = "NanumSquareNeo-eHv.ttf"
    }
    
    class func wanfFont(ofSize size: CGFloat, weight: UIFont.WanfWeight) -> UIFont {
        let font = UIFont(name: weight.rawValue, size: size)
        
        return font ?? systemFont(ofSize: size, weight: .regular)
    }
    
}
