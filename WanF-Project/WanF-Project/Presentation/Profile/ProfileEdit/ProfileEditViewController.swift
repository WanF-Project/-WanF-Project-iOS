//
//  ProfileEditViewController.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/19.
//

import UIKit

import SnapKit

class ProfileEditViewController: UIViewController {
    
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
        // Bind Subcomponents
        profileSettingView.bind(viewModel.profileSettingViewModel)
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
