//
//  ProfilePreviewViewController.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/06/04.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class ProfilePreviewViewController: UIViewController {
    
    //MARK: - View
    let scrollView = UIScrollView()
    let containerView = UIView()
    let profileContentView = ProfileContentView()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        layout()
    }
    
    //MARK: - Function
    func bind(_ viewModel: ProfilePreviewViewModel, id: Int) {
        // Bind Subcomponent View
        profileContentView.bind(viewModel.profileContentViewModel)
        
    }
}

//MARK: - Configure
private extension ProfilePreviewViewController {
    func configureView() {
        
        view.backgroundColor = .wanfBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(profileContentView)
    }
    
    func layout() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        containerView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(30)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.width.equalTo(scrollView.snp.width).inset(15)
        }
        
        profileContentView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
    }
}
