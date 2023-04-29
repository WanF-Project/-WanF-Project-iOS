//
//  ProfileContentKeywordListCell.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/28.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class ProfileContentKeywordListCell: UICollectionViewCell {
    
    //MARK: - View
    private lazy var keywordLabel: UILabel = {
        let label = UILabel()
        
        label.text = "키워드"
        label.font = .wanfFont(ofSize: 13, weight: .regular)
        label.textColor = .wanfLabel
        label.numberOfLines = 1
        label.textAlignment = .center
        
        return label
    }()
    
    //MARK: - LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureView()
        layout()
    }
    
    //MARK: - Function
    func configureCell(_ keyword: String) {
        keywordLabel.text = keyword
        keywordLabel.sizeToFit()
    }
    
    func getContentSize() -> CGSize {
        return  CGSize(width: keywordLabel.frame.width + 10.0, height: keywordLabel.frame.height + 20.0)
    }
}

//MARK: - Configure
private extension ProfileContentKeywordListCell {
    func configureView() {
        contentView.backgroundColor = .wanfLightMint
        
        contentView.addSubview(keywordLabel)
    }
    
    func layout() {
        keywordLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.edges.equalToSuperview().inset(5)
        }
    }
}
