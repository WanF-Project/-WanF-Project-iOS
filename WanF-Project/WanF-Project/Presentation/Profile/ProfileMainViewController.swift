//
//  ProfileMainViewController.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/11.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class ProfileMainViewController: UIViewController {
    
    let profileContentView = ProfileContentView()
    var viewModel: ProfileMainViewModel?
    
    //MARK: - View
    let scrollView = UIScrollView()
    let containerView = UIView()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.text = "• 클릭 시 수정이 가능합니다."
        label.font = .wanfFont(ofSize: 13, weight: .regular)
        label.textColor = .wanfDarkGray
        
        return label
    }()
    
    //MARK: -  LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        layout()
        configureTapGesture()
    }
    
    //MARK: - Fuction
    func bind(_ viewModel: ProfileMainViewModel) {
        self.viewModel = viewModel
        
        // Bind Subcomponent
        profileContentView.bind(viewModel.profileContentViewModel)
    }
}

private extension ProfileMainViewController {
    func configureView() {
        view.backgroundColor = .wanfBackground
        
        navigationItem.title = "프로필"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.wanfLabel,
            NSAttributedString.Key.font : UIFont.wanfFont(ofSize: 15, weight: .bold)
        ]
        
        view.addSubview(scrollView)
        
        [
            profileContentView,
            descriptionLabel
        ]
            .forEach { scrollView.addSubview($0) }
    }
    
    func layout() {
        let verticalInset = 30.0
        let horizontalInset = 50.0
        let offset = 10.0
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        profileContentView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(verticalInset)
            make.horizontalEdges.equalToSuperview().inset(horizontalInset)
            make.width.equalTo(scrollView.snp.width).inset(horizontalInset)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(profileContentView.snp.bottom).offset(offset)
            make.leading.equalTo(profileContentView)
            make.bottom.equalToSuperview().inset(verticalInset)
        }
    }
}

//MARK: - Tap Gesture
extension ProfileMainViewController {
    func configureTapGesture() {
        
        [
            profileContentView.profileImageView,
            profileContentView.profileNicknameLabel,
            profileContentView.profileMajorLabel,
            profileContentView.profileEntranceYearLabel,
            profileContentView.profileBirthLabel,
            profileContentView.profileGenderLabel,
            profileContentView.profileMBTILabel,
            profileContentView.profilePersonalityListTitleLabel,
            profileContentView.profilePurposeListTitleLabel,
            profileContentView.profileContactButton
        ]
            .forEach { $0.isUserInteractionEnabled = true }
        
        let profileImageGesture = UITapGestureRecognizer(target: self, action: #selector(didTapProfileImage))
        profileContentView.profileImageView.addGestureRecognizer(profileImageGesture)
        
        let profileNicknameGesture = UITapGestureRecognizer(target: self, action: #selector(didTapProfileNickname))
        profileContentView.profileNicknameLabel.addGestureRecognizer(profileNicknameGesture)
        
        let profileMajorGesture = UITapGestureRecognizer(target: self, action: #selector(didTapProfileMajor))
        profileContentView.profileMajorLabel.addGestureRecognizer(profileMajorGesture)
        
        let profileEntranceYearGesture = UITapGestureRecognizer(target: self, action: #selector(didTapProfileEntranceYear))
        profileContentView.profileEntranceYearLabel.addGestureRecognizer(profileEntranceYearGesture)
        
        let profileBirthGesture = UITapGestureRecognizer(target: self, action: #selector(didTapProfileBirth))
        profileContentView.profileBirthLabel.addGestureRecognizer(profileBirthGesture)
        
        let profileGenderGesture = UITapGestureRecognizer(target: self, action: #selector(didTapProfileGender))
        profileContentView.profileGenderLabel.addGestureRecognizer(profileGenderGesture)
        
        let profileMBTIGesture = UITapGestureRecognizer(target: self, action: #selector(didTapProfileMBTI))
        profileContentView.profileMBTILabel.addGestureRecognizer(profileMBTIGesture)
        
        let profileContactGesture = UITapGestureRecognizer(target: self, action: #selector(didTapProfileContact))
        profileContentView.profileContactButton.addGestureRecognizer(profileContactGesture)
        
        let profilePersonalityListTitleGesture = UITapGestureRecognizer(target: self, action: #selector(didTapProfilePersonalityListTitle))
        profileContentView.profilePersonalityListTitleLabel.addGestureRecognizer(profilePersonalityListTitleGesture)
        
        let profilePurposeListTitleGesture = UITapGestureRecognizer(target: self, action: #selector(didTapProfilePurposeListTitle))
        profileContentView.profilePurposeListTitleLabel.addGestureRecognizer(profilePurposeListTitleGesture)
        
    }
    
    @objc func didTapProfileImage() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let bearAction = UIAlertAction(title: "곰", style: .default)
        let catAction = UIAlertAction(title: "고양이", style: .default)
        
        [
            cancelAction,
            bearAction,
            catAction
        ]
            .forEach { actionSheet.addAction($0) }
        
        self.present(actionSheet, animated: true)
    }
    
    @objc func didTapProfileNickname() {
        let alertVC = UIAlertController(title: "별명을 입력하세요", message: nil, preferredStyle: .alert)
        alertVC.addTextField()
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let doneAction = UIAlertAction(title: "완료", style: .default)
        
        [
            cancelAction,
            doneAction
        ]
            .forEach { alertVC.addAction($0) }
        
        self.present(alertVC, animated: true)
    }
    
    @objc func didTapProfileMajor() {
        let alertVC = UIAlertController(title: "전공을 입력하세요", message: nil, preferredStyle: .alert)
        alertVC.addTextField()
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let doneAction = UIAlertAction(title: "완료", style: .default)
        
        [
            cancelAction,
            doneAction
        ]
            .forEach { alertVC.addAction($0) }
        
        self.present(alertVC, animated: true)
    }
    
    @objc func didTapProfileEntranceYear() {
        let alertVC = UIAlertController(title: "학번을 입력하세요", message: nil, preferredStyle: .alert)
        alertVC.addTextField() { textField in
            textField.keyboardType = .numberPad
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let doneAction = UIAlertAction(title: "완료", style: .default)
        
        [
            cancelAction,
            doneAction
        ]
            .forEach { alertVC.addAction($0) }
        
        self.present(alertVC, animated: true)
    }
    
    @objc func didTapProfileBirth() {
        let alertVC = UIAlertController(title: "나이를 입력하세요", message: nil, preferredStyle: .alert)
        alertVC.addTextField() { textField in
            textField.keyboardType = .numberPad
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let doneAction = UIAlertAction(title: "완료", style: .default)
        
        [
            cancelAction,
            doneAction
        ]
            .forEach { alertVC.addAction($0) }
        
        self.present(alertVC, animated: true)
    }
    
    @objc func didTapProfileGender() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let womanAction = UIAlertAction(title: "여자", style: .default)
        let manAction = UIAlertAction(title: "남자", style: .default)
        
        [
            cancelAction,
            womanAction,
            manAction
        ]
            .forEach { actionSheet.addAction($0) }
        
        self.present(actionSheet, animated: true)
    }
    
    @objc func didTapProfileMBTI() {
        let alertVC = UIAlertController(title: "MBTI를 입력하세요", message: nil, preferredStyle: .alert)
        alertVC.addTextField()
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let doneAction = UIAlertAction(title: "완료", style: .default)
        
        [
            cancelAction,
            doneAction
        ]
            .forEach { alertVC.addAction($0) }
        
        self.present(alertVC, animated: true)
    }
    
    @objc func didTapProfilePersonalityListTitle() {
        let profileKeywordListVC = ProfileKeywordListViewController()
        profileKeywordListVC.bind(ProfileKeywordListViewModel(type: .personality))
        
        self.present(profileKeywordListVC, animated: true)
    }
    
    @objc func didTapProfilePurposeListTitle() {
        let profileKeywordListVC = ProfileKeywordListViewController()
        profileKeywordListVC.bind(ProfileKeywordListViewModel(type: .purpose))
        
        self.present(profileKeywordListVC, animated: true)
    }
    
    @objc func didTapProfileContact() {
        let alertVC = UIAlertController(title: "연락처를 입력하세요", message: nil, preferredStyle: .alert)
        alertVC.addTextField()
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let doneAction = UIAlertAction(title: "완료", style: .default)
        
        [
            cancelAction,
            doneAction
        ]
            .forEach { alertVC.addAction($0) }
        
        self.present(alertVC, animated: true)
    }
}
