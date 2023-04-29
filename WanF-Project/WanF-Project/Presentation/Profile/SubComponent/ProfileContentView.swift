//
//  ProfileContentView.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/28.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class ProfileContentView: UIView {
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    
    //MARK: - View
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .wanfGray
        
        return imageView
    }()
    
    lazy var profileNicknameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "별명"
        label.font = .wanfFont(ofSize: 15, weight: .bold)
        label.textColor = .wanfLabel
        label.textAlignment = .center
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var profileMajorLabel: UILabel = {
        let label = UILabel()
        
        label.text = "IT융합자율학부 소프트웨어공학전공"
        label.font = .wanfFont(ofSize: 13, weight: .regular)
        label.textColor = .wanfLabel
        label.textAlignment = .center
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var profileEntranceYearLabel: UILabel = {
        let label = UILabel()
        
        label.text = "23학번"
        label.font = .wanfFont(ofSize: 15, weight: .bold)
        label.textColor = .wanfLabel
        label.textAlignment = .center
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var profileBirthLabel: UILabel = {
        let label = UILabel()
        
        label.text = "20살"
        label.font = .wanfFont(ofSize: 15, weight: .bold)
        label.textColor = .wanfLabel
        label.textAlignment = .center
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var profileGenderLabel: UILabel = {
        let label = UILabel()
        
        label.text = "남여"
        label.font = .wanfFont(ofSize: 15, weight: .bold)
        label.textColor = .wanfLabel
        label.textAlignment = .center
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var profileMBTILabel: UILabel = {
        let label = UILabel()
        
        label.text = "MBTI"
        label.font = .wanfFont(ofSize: 15, weight: .bold)
        label.textColor = .wanfLabel
        label.textAlignment = .center
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var profileMidBarView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .wanfMint
        
        return view
    }()
    
    lazy var profilePersonalityListTitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "성격"
        label.font = .wanfFont(ofSize: 15, weight: .bold)
        label.textColor = .wanfLabel
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var profilePersonalityListView: DynamicHeightCollectionView = {
        
        let layout = LeadingAlignmentCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 8
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        
        collectionView.register(ProfileContentKeywordListCell.self, forCellWithReuseIdentifier: "ProfileContentKeywordListCell")
        
        return collectionView
    }()
    
    lazy var profilePurposeListTitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "수업 목표"
        label.font = .wanfFont(ofSize: 15, weight: .bold)
        label.textColor = .wanfLabel
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var profilePurposeListView: DynamicHeightCollectionView = {
        
        let layout = LeadingAlignmentCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 8
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        
        collectionView.register(ProfileContentKeywordListCell.self, forCellWithReuseIdentifier: "ProfileContentKeywordListCell")
        
        return collectionView
    }()
    
    lazy var profileContactButton: UIButton = {
        
        var attributedString = AttributedString("연락처")
        attributedString.font = .wanfFont(ofSize: 15, weight: .bold)
        attributedString.foregroundColor = .wanfLabel
        attributedString.underlineStyle = .single
        attributedString.underlineColor = .wanfLabel
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = attributedString
        
        return UIButton(configuration: configuration)
    }()
    
    
    //MARK: - LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureView()
        layout()
    }
    
    //MARK: - Function
    func bind(_ viewModel: ProfileContentViewModel) {
        
        bindList(viewModel)
    }
    
    func bindList(_ viewModel: ProfileContentViewModel) {
        
        viewModel.personalityCellData
            .drive(profilePersonalityListView.rx.items(cellIdentifier: "ProfileContentKeywordListCell", cellType: ProfileContentKeywordListCell.self)) { index, data, cell in
                cell.configureCell(data)
                cell.frame.size = cell.getContentSize()
                cell.layoutIfNeeded()
            }
            .disposed(by: disposeBag)
        
        viewModel.purposeCellData
            .drive(profilePurposeListView.rx.items(cellIdentifier: "ProfileContentKeywordListCell", cellType: ProfileContentKeywordListCell.self)) {index, data, cell in
                cell.configureCell(data)
                cell.frame.size = cell.getContentSize()
                cell.layoutIfNeeded()
            }
            .disposed(by: disposeBag)
    }
}

//MARK: - Configure
private extension ProfileContentView {
    func configureView() {
        
        backgroundColor = .wanfBackground
        
        layer.borderColor = UIColor.wanfMint.cgColor
        layer.borderWidth = 1.0
        
        [
            profileImageView,
            profileNicknameLabel,
            profileMajorLabel,
            profileEntranceYearLabel,
            profileBirthLabel,
            profileGenderLabel,
            profileMBTILabel,
            profileMidBarView,
            profilePersonalityListTitleLabel,
            profilePersonalityListView,
            profilePurposeListTitleLabel,
            profilePurposeListView,
            profileContactButton
        ]
            .forEach { self.addSubview($0) }
    }
    
    func layout() {
        
        let verticalInset = 50
        let horizontalInset = 10
        let groupOffset = 30
        
        // 프로필 사용자 정보
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(profileImageView.snp.height)
            make.top.equalToSuperview().inset(verticalInset)
        }
        
        profileNicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(groupOffset)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(horizontalInset)
        }
        
        profileMajorLabel.snp.makeConstraints { make in
            make.top.equalTo(profileNicknameLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        // 프로필 특징
        profileEntranceYearLabel.snp.makeConstraints { make in
            make.top.equalTo(profileMajorLabel.snp.bottom).offset(groupOffset)
            make.leading.equalTo(profileMajorLabel).inset(10)
        }
        
        profileBirthLabel.snp.makeConstraints { make in
            make.top.equalTo(profileEntranceYearLabel)
            make.trailing.equalTo(profileMajorLabel).inset(10)
        }
        
        profileGenderLabel.snp.makeConstraints { make in
            make.top.equalTo(profileEntranceYearLabel.snp.bottom).offset(15)
            make.centerX.equalTo(profileEntranceYearLabel)
        }
        
        profileMBTILabel.snp.makeConstraints { make in
            make.top.equalTo(profileGenderLabel)
            make.centerX.equalTo(profileBirthLabel)
        }
        
        // 프로필 구분선
        profileMidBarView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(profileGenderLabel.snp.bottom).offset(groupOffset + 10)
            make.width.equalTo(profileMajorLabel)
            make.centerX.equalToSuperview()
        }
        
        // 프로필 키워드
        profilePersonalityListTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(profileMidBarView.snp.bottom).offset(groupOffset + 10)
            make.leading.equalTo(profileMidBarView)
        }
        
        profilePersonalityListView.snp.makeConstraints { make in
            make.top.equalTo(profilePersonalityListTitleLabel.snp.bottom).offset(13)
            make.centerX.equalToSuperview()
            make.width.equalTo(profileMajorLabel)
        }
        
        profilePurposeListTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(profilePersonalityListView.snp.bottom).offset(groupOffset)
            make.leading.equalTo(profileMidBarView)
        }
        
        profilePurposeListView.snp.makeConstraints { make in
            make.top.equalTo(profilePurposeListTitleLabel.snp.bottom).offset(13)
            make.centerX.equalToSuperview()
            make.width.equalTo(profileMajorLabel)
        }
        
        // 프로필 연락처
        profileContactButton.snp.makeConstraints { make in
            make.top.equalTo(profilePurposeListView.snp.bottom).offset(groupOffset)
            make.bottom.equalToSuperview().inset(verticalInset)
            make.centerX.equalToSuperview()
        }
    }
}
