//
//  ProfileCreateViewController.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/03.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class ProfileCreateViewController: UIViewController {
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    var viewModel: ProfileCreateViewModel?
    
    //MARK: - View
    let doneButton = wanfDoneButton()
    let profileSettingView = ProfileSettingView()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        layout()
        setHandler()
        setNotificationObserver()
    }
    
    //MARK: - Function
    func bind(_ viewModel: ProfileCreateViewModel) {
        
        self.viewModel = viewModel
        
        // Bind Subcomponents
        profileSettingView.bind(viewModel.profileSettingViewModel)
        
        // Make DoneButton Active
        viewModel.makeDoneButtonActive
            .emit(onNext: { profile in
                self.doneButton.isEnabled = true
            })
            .disposed(by: disposeBag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

//MARK: - Configure
private extension ProfileCreateViewController {
    func configure() {
        
        self.view.backgroundColor = .wanfBackground
        
        [
            doneButton,
            profileSettingView
        ]
            .forEach { view.addSubview($0) }
        
    }
    
    func layout() {
        
        doneButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.trailing.equalToSuperview().inset(15)
        }
        
        profileSettingView.snp.makeConstraints { make in
            make.top.equalTo(doneButton.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setHandler() {
        
        // Major
        profileSettingView.majorControl.handler = {
            let profileSingleSelectionListVC = ProfileSingleSelectionListViewController()
            let profileSingleSelectionListViewModel = ProfileSingleSelectionListViewModel(profile: nil, type: .major)
            profileSingleSelectionListVC.bind(profileSingleSelectionListViewModel)
            
            profileSingleSelectionListViewModel.selectedData
                .bind(to: self.viewModel!.profileSettingViewModel.majorControlViewModel.major)
                .disposed(by: self.disposeBag)
            
            self.present(profileSingleSelectionListVC, animated: true)
        }
        
        // Gender
        profileSettingView.genderControl.handler = {
            let handler: (UIAlertAction) -> Void = { action in
                self.viewModel?.profileSettingViewModel.genderControlViewModel.stringValue.accept(action.title ?? "")
            }
            
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "취소", style: .cancel)
            let womanAction = UIAlertAction(title: "여자", style: .default, handler: handler)
            let manAction = UIAlertAction(title: "남자", style: .default, handler: handler)
            
            [
                cancelAction,
                womanAction,
                manAction
            ]
                .forEach { actionSheet.addAction($0) }
            
            self.present(actionSheet, animated: true)
        }
        
        // MBTI
        profileSettingView.mbtiControl.handler = {
            let profileSingleSelectionListVC = ProfileSingleSelectionListViewController()
            profileSingleSelectionListVC.bind(ProfileSingleSelectionListViewModel(profile: nil, type: .MBTI))
            
            self.present(profileSingleSelectionListVC, animated: true)
        }
        
        // Personality
        profileSettingView.profilePersonalityView.handler = {
            let profileKeywordListVC = ProfileKeywordListViewController()
            profileKeywordListVC.bind(ProfileKeywordListViewModel(profile: nil,type: .personality))
            self.present(profileKeywordListVC, animated: true)
        }
        
        // Goal
        profileSettingView.profileGoalView.handler = {
            let profileKeywordListVC = ProfileKeywordListViewController()
            profileKeywordListVC.bind(ProfileKeywordListViewModel(profile: nil,type: .purpose))
            self.present(profileKeywordListVC, animated: true)
        }
    }
}

//MARK: - Keyboard
private extension ProfileCreateViewController {
    
    func setNotificationObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else { return }
        
        var bottomOffset = view.safeAreaInsets.bottom
        let viewIntersection = view.bounds.intersection(keyboardFrame)
        if !viewIntersection.isNull {
            bottomOffset = view.bounds.maxY - viewIntersection.minY
        }
        profileSettingView.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomOffset, right: 0)
    }
}
