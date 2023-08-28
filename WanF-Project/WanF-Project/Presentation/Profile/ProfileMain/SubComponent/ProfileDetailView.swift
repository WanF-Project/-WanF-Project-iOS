//
//  ProfileDetailView.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/25.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class ProfileDetailView: ProfileTapBackgroundControl {
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    
    //MARK: - View
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
    
    lazy var infoStackFir = UIStackView(arrangedSubviews: [profileEntranceYearLabel, profileBirthLabel])
    
    lazy var infoStackSec = UIStackView(arrangedSubviews: [profileGenderLabel, profileMBTILabel])
    
    lazy var profileEntranceYearLabel: UILabel = {
        let label = UILabel()
        
        label.text = "23학번"
        label.font = .wanfFont(ofSize: 15, weight: .bold)
        label.textColor = .wanfBackground
        label.textAlignment = .center
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var profileBirthLabel: UILabel = {
        let label = UILabel()
        
        label.text = "20살"
        label.font = .wanfFont(ofSize: 15, weight: .bold)
        label.textColor = .wanfBackground
        label.textAlignment = .center
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var profileGenderLabel: UILabel = {
        let label = UILabel()
        
        label.text = "남여"
        label.font = .wanfFont(ofSize: 15, weight: .bold)
        label.textColor = .wanfBackground
        label.textAlignment = .center
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var profileMBTILabel: UILabel = {
        let label = UILabel()
        
        label.text = "MBTI"
        label.font = .wanfFont(ofSize: 15, weight: .bold)
        label.textColor = .wanfBackground
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
        label.textColor = .wanfBackground
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
        collectionView.backgroundColor = .none
        
        collectionView.register(ProfileContentKeywordListCell.self, forCellWithReuseIdentifier: "ProfileContentKeywordListCell")
        
        return collectionView
    }()
    
    lazy var profilePurposeListTitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "수업 목표"
        label.font = .wanfFont(ofSize: 15, weight: .bold)
        label.textColor = .wanfBackground
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
        collectionView.backgroundColor = .none
        
        collectionView.register(ProfileContentKeywordListCell.self, forCellWithReuseIdentifier: "ProfileContentKeywordListCell")
        
        return collectionView
    }()
    
    lazy var profileMessageButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "ellipsis.message.fill")
        configuration.baseForegroundColor = .wanfMint
        configuration.buttonSize = .large
        
        return UIButton(configuration: configuration)
    }()
    
    //MARK: - Initialize
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        super.init()
        
        configure()
        layout()
    }
    
    //MARK: - Function
    func bind(_ viewModel: ProfileDetailViewModel) {
        
        viewModel.profile
            .drive(onNext: {
                self.profileNicknameLabel.text = $0.nickname
                self.profileMajorLabel.text = $0.major.name
                self.profileEntranceYearLabel.text = $0.studentId.description
                self.profileBirthLabel.text = $0.age.description
                self.profileGenderLabel.text = $0.gender.values.first
                self.profileMBTILabel.text = $0.mbti
            })
            .disposed(by: disposeBag)
        
        bindList(viewModel)
    }
    
    func bindList(_ viewModel: ProfileDetailViewModel) {

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
private extension ProfileDetailView {
    func configure() {
        
        infoStackFir.alignment = .center
        infoStackFir.axis = .horizontal
        infoStackFir.distribution = .fillEqually
        infoStackFir.spacing = 10
        
        infoStackSec.alignment = .center
        infoStackSec.axis = .horizontal
        infoStackSec.distribution = .fillEqually
        infoStackSec.spacing = 10
        
        [
            profileNicknameLabel,
            profileMajorLabel,
            infoStackFir,
            infoStackSec,
            profileMidBarView,
            profilePersonalityListTitleLabel,
            profilePersonalityListView,
            profilePurposeListTitleLabel,
            profilePurposeListView,
            profileMessageButton
        ]
            .forEach { addSubview($0) }
    }
    
    func layout() {
        let verticalInset = 50
        let horizontalInset = 10
        let groupOffset = 30
        
        // 프로필 사용자 정보
        profileNicknameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(verticalInset)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(horizontalInset)
        }
        
        profileMajorLabel.snp.makeConstraints { make in
            make.top.equalTo(profileNicknameLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        infoStackFir.snp.makeConstraints { make in
            make.top.equalTo(profileMajorLabel.snp.bottom).offset(groupOffset)
            make.centerX.equalToSuperview()
        }
        
        infoStackSec.snp.makeConstraints { make in
            make.top.equalTo(infoStackFir.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(infoStackFir)
        }
        
        // 프로필 구분선
        profileMidBarView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(infoStackSec.snp.bottom).offset(groupOffset + 10)
            make.horizontalEdges.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
        }
        
        // 프로필 키워드
        profilePersonalityListTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(profileMidBarView.snp.bottom).offset(groupOffset + 10)
            make.leading.equalTo(profileMidBarView).offset(10)
        }
        
        profilePersonalityListView.snp.makeConstraints { make in
            make.top.equalTo(profilePersonalityListTitleLabel.snp.bottom).offset(13)
            make.horizontalEdges.equalTo(profileMidBarView).offset(10)
            make.width.equalTo(profileMidBarView)
        }
        
        profilePurposeListTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(profilePersonalityListView.snp.bottom).offset(groupOffset)
            make.leading.equalTo(profileMidBarView).offset(10)
        }
        
        profilePurposeListView.snp.makeConstraints { make in
            make.top.equalTo(profilePurposeListTitleLabel.snp.bottom).offset(13)
            make.horizontalEdges.equalTo(profileMidBarView).offset(10)
            make.width.equalTo(profileMidBarView)
        }
        
        // 프로필 쪽지
        profileMessageButton.snp.makeConstraints { make in
            make.top.equalTo(profilePurposeListView.snp.bottom).offset(groupOffset)
            make.centerX.equalToSuperview()
        }
    }
}

