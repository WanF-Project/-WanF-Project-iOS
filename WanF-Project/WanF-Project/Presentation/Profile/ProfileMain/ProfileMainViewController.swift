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
    var viewModel: ProfileMainViewModel?
    
    //MARK: - View
    let profileContentView = ProfileContentView()
    let EditBarItem: UIBarButtonItem = {
        let item = UIBarButtonItem()
        item.image = UIImage(systemName: "pencil.line")
        return item
    }()
    
    //MARK: -  LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    //MARK: - Fuction
    func bind(_ viewModel: ProfileMainViewModel) {
        self.viewModel = viewModel
        
        // Bind Subcomponent
        profileContentView.bind(viewModel.profileContentViewModel)
        
        // Load
        viewModel.profileContentViewModel.loadProfile.accept(Void())
        
        // Push to ProfileDetail
        EditBarItem.rx.tap
            .bind(to: viewModel.didTapEditBarItem)
            .disposed(by: disposeBag)
        
        viewModel.pushToProfileEdit
            .drive(onNext: { editViewModel in
                let profileEditVC = ProfileEditViewController()
                profileEditVC.bind(editViewModel)
                
                editViewModel.profileEdited
                    .bind(to: viewModel.profileContentViewModel.profileDefaultViewModel.shouldBindProfile)
                    .disposed(by: self.disposeBag)
                
                self.navigationController?.pushViewController(profileEditVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

private extension ProfileMainViewController {
    
    func configureNavigationBar() {
        navigationItem.title = "프로필"
        let textAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.wanfLabel,
            NSAttributedString.Key.font : UIFont.wanfFont(ofSize: 15, weight: .bold)
        ]
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = textAttributes
        appearance.backgroundColor = .wanfBackground
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.tintColor = .wanfMint
        navigationItem.rightBarButtonItem = EditBarItem
    }
    
    func configureView() {
        view.backgroundColor = .wanfBackground
        
        view.addSubview(profileContentView)
    }
    
    func layout() {
        
        profileContentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
    }
}
