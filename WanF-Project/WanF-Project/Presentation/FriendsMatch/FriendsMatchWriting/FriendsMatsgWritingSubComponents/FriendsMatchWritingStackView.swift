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
    let lectureInfoView = FriendsMatchWritingLectureInfoView()
    let titleTextView = FriendsMatchWritingTitleTextView()
    let contentTextView = FriendsMatchWritingContentTextView()
    
    //MARK: - LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureView()
        layout()
    }
}

private extension FriendsMatchWritingStackView {
    func configureView() {
        
        axis = .vertical
        alignment = .fill
        distribution = .fill
        spacing = 15
        
        [
            topBarView,
            lectureInfoView,
            titleTextView,
            contentTextView
        ]
            .forEach { addArrangedSubview($0) }
    }
    
    func layout() {
        
        titleTextView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
