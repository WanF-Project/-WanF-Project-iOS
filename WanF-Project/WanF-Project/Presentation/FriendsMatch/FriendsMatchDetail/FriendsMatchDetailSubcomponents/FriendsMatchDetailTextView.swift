//
//  FriendsMatchDetailTextView.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/18.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class FriendsMatchDetailTextView: UIView {
    
    //MARK: -  View
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        
        label.text = "제목"
        label.textColor = .wanfLabel
        label.font = .wanfFont(ofSize: 20, weight: .extraBold)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        var label = UILabel()
        
        let text = "내용"
        let key = NSAttributedString.Key.self
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10.0
        
        let attributes = [
            key.font : UIFont.wanfFont(ofSize: 15, weight: .regular),
            key.paragraphStyle : style,
            key.foregroundColor : UIColor.wanfLabel
        ]
        let attributedString = NSAttributedString(string: text,attributes: attributes)
        
        label.numberOfLines = 0
        label.attributedText = attributedString
        
        return label
    }()
    
    //MARK: - LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureView()
        layout()
        
    }
}

//MARK: - Configure
private extension FriendsMatchDetailTextView {
    func configureView() {
        
        [
            titleLabel,
            contentLabel
        ]
            .forEach { self.addSubview($0) }
        
    }
    
    func layout() {
        
        let inset = 10.0
        let offset = 16.0
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(inset)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(offset)
            make.horizontalEdges.equalTo(titleLabel)
            make.bottom.equalToSuperview()
        }
    }
}
