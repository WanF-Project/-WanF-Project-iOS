//
//  ProfileDefaultView.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/25.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class ProfileDefaultView: UIView {
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    
    //MARK: - View
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "WanfProfileDefaultImage")
        imageView.tintColor = .wanfMint
        
        return imageView
    }()
    
    lazy var bottomBackgroundControl = ProfileTapBackgroundControl()
    
    lazy var profileNicknameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "별명"
        label.font = .wanfFont(ofSize: 15, weight: .bold)
        label.textColor = .wanfBackground
        label.textAlignment = .center
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var profileMajorLabel: UILabel = {
        let label = UILabel()
        
        label.text = "IT융합자율학부 소프트웨어공학전공"
        label.font = .wanfFont(ofSize: 13, weight: .regular)
        label.textColor = .wanfBackground
        label.textAlignment = .center
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var detailView = ProfileDetailView()
    
    //MARK: - Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        
        configure()
        layout()
        
        bottomBackgroundControl.rx.tapForHidden
            .bind(to: detailView.rx.isHidden)
            .disposed(by: disposeBag)
        
        detailView.rx.tapForHidden
            .bind(to: bottomBackgroundControl.rx.isHidden)
            .disposed(by: disposeBag)
    }
}

//MARK: - Configure
private extension ProfileDefaultView {
    func configure() {
        
        self.isUserInteractionEnabled = true
        profileImageView.isUserInteractionEnabled = true
        detailView.isHidden = true
        
        addSubview(profileImageView)
        
        [
            bottomBackgroundControl,
            detailView
        ]
            .forEach { profileImageView.addSubview($0) }
        
        [
            profileNicknameLabel,
            profileMajorLabel
        ]
            .forEach { bottomBackgroundControl.addSubview($0) }
    }
    
    func layout() {
        profileImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        detailView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bottomBackgroundControl.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.height.equalTo(100)
        }
        
        profileNicknameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
        }
        
        profileMajorLabel.snp.makeConstraints { make in
            make.top.equalTo(profileNicknameLabel.snp.bottom).offset(15)
            make.leading.equalTo(profileNicknameLabel)
            make.bottom.equalToSuperview().inset(20)
        }
    }
}
