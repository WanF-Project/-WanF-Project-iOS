//
//  RandomFriendsViewController.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/14.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class RandomFriendsViewController: UIViewController {
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    
    //MARK: - View
    private lazy var profileContentView = ProfileContentView()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        layout()
    }
    
    //MARK: - Function
    func bind(_ viewModel: RandomFriendsViewModel) {
        
        // Bind Subcomponent
        profileContentView.bind(viewModel.profileContentViewModel)
        
        // ViewModel -> View
        
        // View -> ViewModel
        viewModel.loadRandomFriends.accept(Void())
        
    }
}

private extension RandomFriendsViewController {
    func configure() {
        view.backgroundColor = .wanfBackground
        
        view.addSubview(profileContentView)
    }
    
    func layout() {
        profileContentView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        profileContentView.defaultView.detailView.profileNicknameLabel.snp.updateConstraints { make in
            make.top.equalToSuperview().inset(100)
        }
    }
}
