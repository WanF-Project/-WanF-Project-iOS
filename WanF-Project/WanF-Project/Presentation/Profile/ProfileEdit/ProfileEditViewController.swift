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
    }
    
    //MARK: - Function
    func bind(_ viewModel: ProfileEditViewModel) {
        
        self.viewModel = viewModel
        
        // Bind Subcomponents
        profileSettingView.bind(viewModel.profileSettingViewModel)
        
        // View -> View
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
                    self.viewModel?.profileSettingViewModel.settingPhotoButtonViewModel.shouldChangePreImage.accept(image)
                }
            }
        }
        
        self.dismiss(animated: true)
    }
}
