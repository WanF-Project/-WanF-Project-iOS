//
//  BannerListSupplementaryFooterView.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/10/28.
//

import UIKit

import SnapKit

class BannerListSupplementaryFooterView: UICollectionReusableView {
    
    //MARK: - View
    lazy var pageControl = UIPageControl()
    
    //MARK: - LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configure()
        layout()
    }
}

// Configuration
private extension BannerListSupplementaryFooterView {
    func configure() {
        pageControl.numberOfPages = 5
        pageControl.currentPage = 0
        
        self.addSubview(pageControl)
    }
    
    func layout() {
        pageControl.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview().inset(-25)
        }
    }
}
