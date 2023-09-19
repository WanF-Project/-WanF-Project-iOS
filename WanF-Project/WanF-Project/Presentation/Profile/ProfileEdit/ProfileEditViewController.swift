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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        layout()
    }
    
    //MARK: - Function
    func bind(_ viewModel: ProfileEditViewModel) {
        
    }
}

private extension ProfileEditViewController {
    func configure() {
        view.backgroundColor = .wanfBackground
        
        view.addSubview(profileSettingView)
    }
    
    func layout() {
        profileSettingView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
