//
//  ExUIColor.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/01.
//

import UIKit

extension UIColor {
    
    //MARK: - WanF Color
    //Some convenience methods to create WanF colors.
    
    class var wanfBackground: UIColor { UIColor(named: "wanfBackground") ?? systemBackground }
    
    class var wanfLabel: UIColor { UIColor(named: "wanfLabel") ?? label }
    
    class var wanfMint: UIColor { UIColor(named: "wanfMint") ?? label }
    
    class var wanfLightMint: UIColor { UIColor(named: "wanfLightMint") ?? label }
    
    class var wanfNavy: UIColor { UIColor(named: "wanfNavy") ?? label }
    
    class var wanfGray: UIColor { UIColor(named: "wanfGray") ?? label }
    
    class var wanfLightGray: UIColor {UIColor(named: "wanfLightGray") ?? label }
    
    class var wanfDarkGray: UIColor { UIColor(named: "wanfDarkGray") ?? label }
    
}
