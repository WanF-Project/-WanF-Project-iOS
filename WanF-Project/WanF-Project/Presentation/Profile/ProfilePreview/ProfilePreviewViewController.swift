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
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    
    //MARK: - View
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
        
        // Load Profile Preview
        viewModel.profileContentViewModel.loadProfilePreview.accept(id)
        
        // Push to MessageDetail
        viewModel.pushToMessageDetail
            .drive(onNext: { viewModel in
                let MessageDetailVC = MessageDetailViewController()
                guard let presentingVC = self.presentingViewController else { return }
                
                self.dismiss(animated: true) {
                    MessageDetailVC.bind(viewModel)
                    presentingVC.present(MessageDetailVC, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
}

//MARK: - Configure
private extension ProfilePreviewViewController {
    func configureView() {
        
        view.backgroundColor = .wanfBackground
        
        view.addSubview(profileContentView)
    }
    
    func layout() {
        profileContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
