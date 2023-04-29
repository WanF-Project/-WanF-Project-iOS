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
    
    let scrollView = UIScrollView()
    let containerView = UIView()
    
    //MARK: -  LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        layout()
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
        scrollView.addSubview(profileContentView)
    }
    
    func layout() {
        let verticalInset = 10.0
        let horizontalInset = 30.0
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        profileContentView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(verticalInset)
            make.horizontalEdges.equalToSuperview().inset(horizontalInset)
            make.width.equalTo(scrollView.snp.width).inset(horizontalInset)
        }
    }
}
