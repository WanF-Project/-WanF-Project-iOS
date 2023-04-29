//
//  DynamicHeightCollectionView.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/29.
//

import UIKit

/// 아이템 수에 따라 CollectionView의 전체 높이를 유동적으로 조절하는 커스텀 UICollectionView 클래스
class DynamicHeightCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
