//
//  FriendsMatchWritingLectureInfoView.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/14.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class FriendsMatchWritingLectureInfoView: UIView {
    
    //MARK: -  View
    private lazy var lectureName: UILabel = {
        var label = UILabel()
        
        label.text = "강의명"
        label.font = .wanfFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var professorName: UILabel = {
        var label = UILabel()
        
        label.text = "교수명"
        label.font = .wanfFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 1
        
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
private extension FriendsMatchWritingLectureInfoView {
    func configureView() {
        
        backgroundColor = .wanfLightMint
        
        [
            lectureName,
            professorName
        ]
            .forEach { self.addSubview($0) }
        
    }
    
    func layout() {
        
        let verticalInset = 25
        let horizontalInset = 35
        
        lectureName.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(verticalInset)
            make.horizontalEdges.equalToSuperview().inset(horizontalInset)
        }
        
        professorName.snp.makeConstraints { make in
            make.top.equalTo(lectureName.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(lectureName)
            make.bottom.equalToSuperview().inset(verticalInset)
        }
    }
}
