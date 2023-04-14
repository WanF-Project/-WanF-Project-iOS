//
//  FriendsMatchWritingStackView.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/14.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class FriendsMatchWritingStackView: UIStackView {
    
    //MARK: - View
    let topBarView = FriendsMatchWritingTopBarView()
    
    //MARK: - LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureView()
        layout()
    }
}

private extension FriendsMatchWritingStackView {
    func configureView() {
        
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .equalSpacing
        self.spacing = 15
        
        [
            topBarView
        ]
            .forEach { addArrangedSubview($0) }
    }
    
    func layout() {
        
    }
}
