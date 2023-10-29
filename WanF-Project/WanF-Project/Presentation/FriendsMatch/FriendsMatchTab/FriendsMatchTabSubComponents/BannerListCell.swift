//
//  BannerListCell.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/10/28.
//

import UIKit

import SnapKit

class BannerListCell: UICollectionViewCell {
    
    //MARK: - View
    private lazy var imageView = UIImageView()
    
    //MARK: - LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configure()
        layout()
    }
    
    func configureCell(_ banner: BannerEntity) {
        let url = URL(string: banner.image.imageUrl)
        url?.image({ image in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        })
    }
}

// Configuration
private extension BannerListCell {
    func configure() {
        self.contentView.addSubview(imageView)
        self.contentView.backgroundColor = .wanfGray
    }
    
    func layout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(120)
        }
    }
}
