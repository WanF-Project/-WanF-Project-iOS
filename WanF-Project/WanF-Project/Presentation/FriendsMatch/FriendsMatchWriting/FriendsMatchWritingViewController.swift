//
//  FriendsMatchWritingViewController.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/11.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class FriendsMatchWritingViewController: UIViewController {
    
    //MARK: - View
    let stackView = FriendsMatchWritingStackView()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        layout()
    }
    
    //MARK: - Function
    func bind(_ viewModel: FriendsMatchWritingViewModel){
        
    }
}

private extension FriendsMatchWritingViewController {
    func configureView() {
        view.backgroundColor = .wanfBackground
        
        view.addSubview(stackView)
    }
    
    func layout() {
        
        let inset = 10
        
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(inset)
        }
        
    }
}
