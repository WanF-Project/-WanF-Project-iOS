//
//  FriendsMatchWritingContentTextView.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/14.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class FriendsMatchWritingContentTextView: UITextView {
    
    //MARK: - LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureView()
    }
}

//MARK: - Configure
private extension FriendsMatchWritingContentTextView {
    func configureView() {
        
        text = "내용을 입력하세요"
        font = .wanfFont(ofSize: 18, weight: .regular)
        tintColor = .wanfMint
        textColor = .placeholderText
        
    }
}
