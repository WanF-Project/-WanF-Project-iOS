//
//  ClubListViewController.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/09.
//

import UIKit

import RxSwift
import RxCocoa

class ClubListViewController: UIViewController {
    
    private let profileBarButton = ProfileBarButtonItem()
    private let addBarButton = AddBarButtonItem()
    private let clubListView = ClubListTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        layout()
    }
}

private extension ClubListViewController {
    
    func configureNavigationBar() {
        
        navigationItem.title = "나의 모임"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.wanfLabel,
            NSAttributedString.Key.font : UIFont.wanfFont(ofSize: 15, weight: .bold)
        ]
        navigationController?.navigationBar.tintColor = .wanfMint
        navigationItem.leftBarButtonItem = profileBarButton
        navigationItem.rightBarButtonItem = addBarButton
    }
    
    func configure() {
        
        view.backgroundColor = .wanfBackground
        configureNavigationBar()
        
        view.addSubview(clubListView)
    }
    
    func layout() {
        clubListView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(5)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
    }
}
