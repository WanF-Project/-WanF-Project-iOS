//
//  FriendsMatchListCell.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/11.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class FriendsMatchListCell: UITableViewCell {
    
    //MARK: - View
    private lazy var containerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .wanfBackground
        view.layer.borderColor = UIColor.wanfMint.cgColor
        view.layer.borderWidth = CGFloat(1.0)
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        let attributedKey = NSAttributedString.Key.self
        let titleAttributes = [
            attributedKey.font : UIFont.wanfFont(ofSize: 15, weight: .bold),
            attributedKey.foregroundColor : UIColor.wanfLabel
        ]
        let attributedTitle = NSAttributedString(string: "제목", attributes: titleAttributes)
        
        label.attributedText = attributedTitle
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        
        let attributedKey = NSAttributedString.Key.self
        let subtitleAttributes = [
            attributedKey.font : UIFont.wanfFont(ofSize: 15, weight: .regular),
            attributedKey.foregroundColor : UIColor.wanfDarkGray
        ]
        let attributedSubtitle = NSAttributedString(string: "강의명: 교수명", attributes: subtitleAttributes)
        
        label.attributedText = attributedSubtitle
        label.numberOfLines = 1
        
        return label
    }()
    
    //MARK: - LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
    
    //MARK: - Data
    func setCellData(_ data: FriendsMatchListItemEntity) {
        let lectureInfo = data.lectureInfo
        
        titleLabel.text = data.title
        subtitleLabel.text = "\(lectureInfo.lectureName) : \(lectureInfo.professorName)"
    }
}

//MARK: - Configure
private extension FriendsMatchListCell {
    func layout() {
        self.contentView.addSubview(containerView)
        
        [
            titleLabel,
            subtitleLabel
        ]
            .forEach { containerView.addSubview($0) }
        
        containerView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(25)
        }
        
        let inset: CGFloat = 20
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(inset)
            make.leading.trailing.equalToSuperview().inset(inset)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.equalToSuperview().inset(inset)
            
        }
    }
}
