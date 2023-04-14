//
//  FriendsMatchWritingTitleTextView.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/14.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class FriendsMatchWritingTitleTextView: UITextView {
    
    //MARK: - LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureView()
    }
}

//MARK: - Configure
private extension FriendsMatchWritingTitleTextView {
    func configureView() {
        
        textContainer.maximumNumberOfLines = 1
        text = "제목을 입력하세요"
        font = .wanfFont(ofSize: 23, weight: .bold)
        tintColor = .wanfMint
        textColor = .placeholderText
        
    }
}

