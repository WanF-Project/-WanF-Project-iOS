//
//  ExUIView.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/01.
//

import UIKit

extension UIView {
    
    //MARK: - adjusting Corner Radius
    enum Corner {
        case topLeft, topRight
        case bottomLeft, bottomRight
    }
    
    func roundCorner(round: Int, _ corners: [Corner]){
        self.layer.cornerRadius = CGFloat(round)
        var cornerMasks = CACornerMask()
        
        corners.forEach { corner in
            switch corner {
            case .topLeft:
                cornerMasks.insert(.layerMinXMinYCorner)
            case .topRight:
                cornerMasks.insert(.layerMaxXMinYCorner)
            case .bottomLeft:
                cornerMasks.insert(.layerMinXMaxYCorner)
            case .bottomRight:
                cornerMasks.insert(.layerMaxXMaxYCorner)
            }
        }
        
        self.layer.maskedCorners = cornerMasks
    }
    
}
