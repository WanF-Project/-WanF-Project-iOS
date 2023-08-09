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
    
    let disposeBag = DisposeBag()
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
    
    let refreshControl = UIRefreshControl()
    
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
        
        // Load
        viewModel.shouldLoadProfile.accept(Void())
        
        // Refresh
        refreshControl.rx.controlEvent(.valueChanged)
            .withLatestFrom(Observable.just(refreshControl))
            .subscribe(onNext: { refreshControl in
                viewModel.shouldRefreshProfile.accept(Void())
                refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)
    }
}

private extension ProfileMainViewController {
    func configureView() {
        view.backgroundColor = .wanfBackground
        
        scrollView.refreshControl = refreshControl
        
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
        
        let bearAction = UIAlertAction(title: "곰", style: .default) { _ in
            guard let profile = self.profileContentView.profileData,
                  let personality = (profile.personality as NSDictionary).allKeys as? Array<String>,
                  let purpose = (profile.purpose as NSDictionary).allKeys as? Array<String> else { return }
            
            let profileImageString = "BEAR"
            let profileWriting = ProfileRequestEntity(profileImage: profileImageString, nickname: profile.nickname, majorId: profile.major?.id, entranceYear: profile.entranceYear ?? 0, birth: profile.birth ?? 0, gender: profile.gender?.keys.first, mbti: profile.mbti, personality: personality, purpose: purpose, contact: profile.contact)
            self.viewModel?.shouldPatchProfile.accept(profileWriting)
        }
        
        let catAction = UIAlertAction(title: "고양이", style: .default) { _ in
            guard let profile = self.profileContentView.profileData,
                  let personality = (profile.personality as NSDictionary).allKeys as? Array<String>,
                  let purpose = (profile.purpose as NSDictionary).allKeys as? Array<String> else { return }
            
            let profileImageString = "CAT"
            let profileWriting = ProfileRequestEntity(profileImage: profileImageString, nickname: profile.nickname, majorId: profile.major?.id, entranceYear: profile.entranceYear ?? 0, birth: profile.birth ?? 0, gender: profile.gender?.keys.first, mbti: profile.mbti, personality: personality, purpose: purpose, contact: profile.contact)
            self.viewModel?.shouldPatchProfile.accept(profileWriting)
        }
        
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
        let doneAction = UIAlertAction(title: "완료", style: .default) { _ in
            guard let profile = self.profileContentView.profileData,
                  let personality = (profile.personality as NSDictionary).allKeys as? Array<String>,
                  let purpose = (profile.purpose as NSDictionary).allKeys as? Array<String> else { return }
            let profileNickname = alertVC.textFields?[0].text
            
            let profileWriting = ProfileRequestEntity(profileImage: profile.profileImage, nickname: profileNickname, majorId: profile.major?.id, entranceYear: profile.entranceYear ?? 0, birth: profile.birth ?? 0, gender: profile.gender?.keys.first, mbti: profile.mbti, personality: personality, purpose: purpose, contact: profile.contact)
            self.viewModel?.shouldPatchProfile.accept(profileWriting)
        }
        
        [
            cancelAction,
            doneAction
        ]
            .forEach { alertVC.addAction($0) }
        
        self.present(alertVC, animated: true)
    }
    
    @objc func didTapProfileMajor() {
        guard let profile = self.profileContentView.profileData else { return }
        
        let profileSingleSelectionListVC = ProfileSingleSelectionListViewController<MajorEntity>()
        profileSingleSelectionListVC.bind(ProfileSingleSelectionListViewModel<MajorEntity>())
        
        self.present(profileSingleSelectionListVC, animated: true)
    }
    
    @objc func didTapProfileEntranceYear() {
        let alertVC = UIAlertController(title: "학번을 입력하세요", message: nil, preferredStyle: .alert)
        alertVC.addTextField() { textField in
            textField.keyboardType = .numberPad
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let doneAction = UIAlertAction(title: "완료", style: .default) { _ in
            guard let profile = self.profileContentView.profileData,
                  let personality = (profile.personality as NSDictionary).allKeys as? Array<String>,
                  let purpose = (profile.purpose as NSDictionary).allKeys as? Array<String>,
                  let entranceYear = alertVC.textFields?[0].text,
                  let profileEntranceYear = Int(entranceYear) else { return }
            
            let profileWriting = ProfileRequestEntity(profileImage: profile.profileImage, nickname: profile.nickname, majorId: profile.major?.id, entranceYear: profileEntranceYear, birth: profile.birth ?? 0, gender: profile.gender?.keys.first, mbti: profile.mbti, personality: personality, purpose: purpose, contact: profile.contact)
            self.viewModel?.shouldPatchProfile.accept(profileWriting)
        }
        
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
        let doneAction = UIAlertAction(title: "완료", style: .default) { _ in
            guard let profile = self.profileContentView.profileData,
                  let personality = (profile.personality as NSDictionary).allKeys as? Array<String>,
                  let purpose = (profile.purpose as NSDictionary).allKeys as? Array<String>,
                  let birth = alertVC.textFields?[0].text,
                  let profileBirth = Int(birth) else { return }
            
            let profileWriting = ProfileRequestEntity(profileImage: profile.profileImage, nickname: profile.nickname, majorId: profile.major?.id, entranceYear: profile.entranceYear ?? 0, birth: profileBirth ?? 0, gender: profile.gender?.keys.first, mbti: profile.mbti, personality: personality, purpose: purpose, contact: profile.contact)
            self.viewModel?.shouldPatchProfile.accept(profileWriting)
        }
        
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
        let womanAction = UIAlertAction(title: "여자", style: .default) { _ in
            guard let profile = self.profileContentView.profileData,
                  let personality = (profile.personality as NSDictionary).allKeys as? Array<String>,
                  let purpose = (profile.purpose as NSDictionary).allKeys as? Array<String> else { return }
            let profileGender = "FEMALE"
            let profileWriting = ProfileRequestEntity(profileImage: profile.profileImage, nickname: profile.nickname, majorId: profile.major?.id, entranceYear: profile.entranceYear ?? 0, birth: profile.birth ?? 0, gender: profileGender, mbti: profile.mbti, personality: personality, purpose: purpose, contact: profile.contact)
            self.viewModel?.shouldPatchProfile.accept(profileWriting)
        }
        let manAction = UIAlertAction(title: "남자", style: .default) { _ in
            guard let profile = self.profileContentView.profileData,
                  let personality = (profile.personality as NSDictionary).allKeys as? Array<String>,
                  let purpose = (profile.purpose as NSDictionary).allKeys as? Array<String> else { return }
            let profileGender = "MALE"
            let profileWriting = ProfileRequestEntity(profileImage: profile.profileImage, nickname: profile.nickname, majorId: profile.major?.id, entranceYear: profile.entranceYear ?? 0, birth: profile.birth ?? 0, gender: profileGender, mbti: profile.mbti, personality: personality, purpose: purpose, contact: profile.contact)
            self.viewModel?.shouldPatchProfile.accept(profileWriting)
        }
        
        [
            cancelAction,
            womanAction,
            manAction
        ]
            .forEach { actionSheet.addAction($0) }
        
        self.present(actionSheet, animated: true)
    }
    
    @objc func didTapProfileMBTI() {
        guard let profile = self.profileContentView.profileData else { return }
        
        let profileSingleSelectionListVC = ProfileSingleSelectionListViewController<MbtiEntity>()
        profileSingleSelectionListVC.bind(ProfileSingleSelectionListViewModel<MbtiEntity>())
        
        self.present(profileSingleSelectionListVC, animated: true)
    }
    
    @objc func didTapProfilePersonalityListTitle() {
        guard let profile = self.profileContentView.profileData else { return }
        
        let profileKeywordListVC = ProfileKeywordListViewController()
        profileKeywordListVC.bind(ProfileKeywordListViewModel(type: .personality))
        
        self.present(profileKeywordListVC, animated: true)
    }
    
    @objc func didTapProfilePurposeListTitle() {
        guard let profile = self.profileContentView.profileData else { return }
        
        let profileKeywordListVC = ProfileKeywordListViewController()
        profileKeywordListVC.bind(ProfileKeywordListViewModel(type: .purpose))
        
        self.present(profileKeywordListVC, animated: true)
    }
    
    @objc func didTapProfileContact() {
        let alertVC = UIAlertController(title: "연락처를 입력하세요", message: nil, preferredStyle: .alert)
        alertVC.addTextField()
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let doneAction = UIAlertAction(title: "완료", style: .default) { _ in
            guard let profile = self.profileContentView.profileData,
                  let personality = (profile.personality as NSDictionary).allKeys as? Array<String>,
                  let purpose = (profile.purpose as NSDictionary).allKeys as? Array<String> else { return }
            let profileContact = alertVC.textFields?[0].text
            
            let profileWriting = ProfileRequestEntity(profileImage: profile.profileImage, nickname: profile.nickname, majorId: profile.major?.id, entranceYear: profile.entranceYear ?? 0, birth: profile.birth ?? 0, gender: profile.gender?.keys.first, mbti: profile.mbti, personality: personality, purpose: purpose, contact: profileContact)
            self.viewModel?.shouldPatchProfile.accept(profileWriting)
        }
        
        [
            cancelAction,
            doneAction
        ]
            .forEach { alertVC.addAction($0) }
        
        self.present(alertVC, animated: true)
    }
}
