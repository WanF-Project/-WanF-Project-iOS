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
    var viewModel: RandomFriendsViewModel?
    
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
        
        self.viewModel = viewModel
        
        // Bind Subcomponent
        profileContentView.bind(viewModel.profileContentViewModel)
        
        // ViewModel -> View
        
        // View -> ViewModel
        viewModel.didLoadRandom.accept(Void())
        
    }
    
    @objc func swipeNextFriend(_ gerstureRecognizer: UISwipeGestureRecognizer) {
        
        if gerstureRecognizer.direction == .left {
            if viewModel != nil {
                viewModel!.randomSubject.onNext(viewModel!.swipeSubject)
                viewModel!.didSwipeProfile.accept(Void())
            }
        }
    }
}

private extension RandomFriendsViewController {
    func configure() {
        view.backgroundColor = .wanfBackground
        view.addSubview(profileContentView)
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeNextFriend))
        swipeGesture.direction = .left
        profileContentView.addGestureRecognizer(swipeGesture)
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
