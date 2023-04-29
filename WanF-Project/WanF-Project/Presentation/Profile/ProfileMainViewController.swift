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
