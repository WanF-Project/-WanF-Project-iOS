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
    private lazy var refreshButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 30.0, weight: .bold)
        configuration.image = UIImage(systemName: "arrow.counterclockwise")
        configuration.baseForegroundColor = .wanfMint
        
        var button = UIButton()
        button.configuration = configuration
        return button
    }()
    
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
        viewModel.isHiddenForRefresh
            .bind(to: refreshButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        // View -> ViewModel
        viewModel.didLoadRandom.accept(Void())
        
        refreshButton.rx.tap
            .subscribe(onNext: { _ in
                viewModel.randomPage.clearRandomPage()
                viewModel.randomSubject.onNext(viewModel.loadSubject)
                viewModel.didLoadRandom.accept(Void())
                self.refreshButton.isHidden = true
            })
            .disposed(by: disposeBag)
        
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
        refreshButton.isHidden = true
        
        [
            profileContentView,
            refreshButton
        ]
            .forEach { view.addSubview($0) }
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeNextFriend))
        swipeGesture.direction = .left
        profileContentView.addGestureRecognizer(swipeGesture)
    }
    
    func layout() {
        
        refreshButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
        }
        
        profileContentView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        profileContentView.defaultView.detailView.profileNicknameLabel.snp.updateConstraints { make in
            make.top.equalToSuperview().inset(100)
        }
    }
}
