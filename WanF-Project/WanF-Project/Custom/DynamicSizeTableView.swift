//
//  DynamicSizeTableView.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/16.
//

import UIKit

class DynamicSizeTableView: UITableView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        adjustSize()
    }
    
    private func adjustSize() {
        if !__CGSizeEqualToSize(frame.size, contentSize) {
            frame.size = contentSize
        }
    }
}
