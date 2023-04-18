//
//  FriendsMatchDetailInfoView.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/18.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class FriendsMatchDetailInfoView: UIView {
    
    //MARK: - View
    private lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "별명"
        label.font = .wanfFont(ofSize: 16, weight: .bold)
        label.textColor = .wanfLabel
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        
        label.text = "2023.05.03"
        label.font = .wanfFont(ofSize: 13, weight: .light)
        label.textColor = .wanfLabel
        
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
private extension FriendsMatchDetailInfoView {
    
    func configureView() {
        
    }
    
    func layout() {
        
        [
            nicknameLabel,
            dateLabel
        ]
            .forEach { addSubview($0) }
        
        let inset = 10.0
        let offset = 10.0
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(inset)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(offset)
            make.leading.equalTo(nicknameLabel)
            make.bottom.equalToSuperview()
        }
        
    }
}
