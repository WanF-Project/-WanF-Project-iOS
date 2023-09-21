//
//  ProfileEditViewController.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/19.
//

import UIKit
import PhotosUI

import SnapKit
import RxSwift
import RxCocoa

class ProfileEditViewController: UIViewController {
    
    var viewModel: ProfileEditViewModel?
    let disposeBag = DisposeBag()
    
    
    //MARK: - View
    let profileSettingView = ProfileSettingView()
    let doneBarItem: UIBarButtonItem = {
        let item = UIBarButtonItem()
        let attributes = [
            NSAttributedString.Key.font : UIFont.wanfFont(ofSize: 13, weight: .bold)
        ]
        item.title = "완료"
        item.setTitleTextAttributes(attributes, for: .normal)
        return item
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        layout()
        setHandler()
    }
    
    //MARK: - Function
    func bind(_ viewModel: ProfileEditViewModel) {
        
        self.viewModel = viewModel
        
        // Bind Subcomponents
        profileSettingView.bind(viewModel.profileSettingViewModel)
        
        // View -> ViewModel
        doneBarItem.rx.tap
            .bind(to: viewModel.didTapDoneButton)
            .disposed(by: disposeBag)
        
        // ViewModel -> View
        viewModel.presentPickerView
            .drive(onNext: {
                var configuration = PHPickerConfiguration()
                configuration.filter = .images
                configuration.selectionLimit = 1
                
                let photoPickerVC = PHPickerViewController(configuration: configuration)
                photoPickerVC.delegate = self
                self.present(photoPickerVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.dismiss
            .drive(onNext: {_ in
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    func setHandler() {
        
        // Major
        profileSettingView.majorControl.handler = {
            let profileSingleSelectionListVC = ProfileSingleSelectionListViewController<MajorEntity>()
            let profileSingleSelectionListViewModel = ProfileSingleSelectionListViewModel<MajorEntity>()
            profileSingleSelectionListVC.bind(profileSingleSelectionListViewModel)
            
            profileSingleSelectionListViewModel.selectedData
                .map { $0 as any Nameable }
                .bind(to: self.viewModel!.profileSettingViewModel.majorControlViewModel.nameableValue)
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
            let profileSingleSelectionListVC = ProfileSingleSelectionListViewController<MbtiEntity>()
            let profileSingleSelectionListViewModel = ProfileSingleSelectionListViewModel<MbtiEntity>()
            profileSingleSelectionListVC.bind(profileSingleSelectionListViewModel)
            
            profileSingleSelectionListViewModel.selectedData
                .map { $0 as any Nameable }
                .bind(to: self.viewModel!.profileSettingViewModel.mbtiControlViewModel.nameableValue)
                .disposed(by: self.disposeBag)
            
            self.present(profileSingleSelectionListVC, animated: true)
        }
        
        // Personality
        profileSettingView.profilePersonalityView.handler = {
            let profileKeywordListVC = ProfileKeywordListViewController()
            let profileKeywordListViewModel = ProfileKeywordListViewModel(type: .personality)
            profileKeywordListVC.bind(profileKeywordListViewModel)
            
            profileKeywordListViewModel.selectedData
                .bind(to: self.viewModel!.profileSettingViewModel.personalitySettingViewModel.keywords)
                .disposed(by: self.disposeBag)
            
            
            self.present(profileKeywordListVC, animated: true)
        }
        
        // Goal
        profileSettingView.profileGoalView.handler = {
            let profileKeywordListVC = ProfileKeywordListViewController()
            let profileKeywordListViewModel = ProfileKeywordListViewModel(type: .purpose)
            profileKeywordListVC.bind(profileKeywordListViewModel)
            
            profileKeywordListViewModel.selectedData
                .bind(to: self.viewModel!.profileSettingViewModel.goalSettingViewModel.keywords)
                .disposed(by: self.disposeBag)
            
            self.present(profileKeywordListVC, animated: true)
        }
    }
}

private extension ProfileEditViewController {
    func configure() {
        view.backgroundColor = .wanfBackground
        view.addSubview(profileSettingView)
        
        navigationItem.rightBarButtonItem = doneBarItem
    }
    
    func layout() {
        profileSettingView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

//MARK: - PHPickerViewControllerDelegate
extension ProfileEditViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        guard let selection = results.first else { return }
        let imageProvider = selection.itemProvider
        
        if imageProvider.canLoadObject(ofClass: UIImage.self) {
            imageProvider.loadObject(ofClass: UIImage.self) { image, error in
                if let error = error {
                    debugPrint("ERROR: \(error)")
                    return
                }

                guard let image = image as? UIImage else { return }
                DispatchQueue.main.async {
                    self.viewModel?.profileSettingViewModel.settingPhotoButtonViewModel.shouldChangePreImageForCreate.accept(image)
                }
            }
        }
        
        self.dismiss(animated: true)
    }
}
