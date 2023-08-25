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
    let profileContentView = ProfileContentView()
    var viewModel: ProfileMainViewModel?
    
    //MARK: - View
    let scrollView = UIScrollView()
    let containerView = UIView()
    let refreshControl = UIRefreshControl()
    
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
        
        // Load
        viewModel.shouldLoadProfile.accept(Void())
        
        // Refresh
        refreshControl.rx.controlEvent(.valueChanged)
            .withLatestFrom(Observable.just(refreshControl))
            .subscribe(onNext: { refreshControl in
                viewModel.shouldRefreshProfile.accept(Void())
                refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)
    }
}

private extension ProfileMainViewController {
    func configureView() {
        view.backgroundColor = .wanfBackground
        
        scrollView.refreshControl = refreshControl
        
        navigationItem.title = "프로필"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.wanfLabel,
            NSAttributedString.Key.font : UIFont.wanfFont(ofSize: 15, weight: .bold)
        ]
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(profileContentView)
    }
    
    func layout() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        profileContentView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
    }
}
