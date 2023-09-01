//
//  MessageListViewController.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/01.
//

import UIKit

class MessageListViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    //MARK: - Function
    func bind(_ viewModel: MessageListViewModel) {
        
    }
}

//MARK: - Configure
extension MessageListViewController {
    
    func configureNavigationBar() {
        navigationItem.title = "쪽지 목록"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.wanfLabel,
            NSAttributedString.Key.font : UIFont.wanfFont(ofSize: 15, weight: .bold)
        ]
        navigationController?.navigationBar.tintColor = .wanfMint
    }
    
    func configure() {
        configureNavigationBar()
        view.backgroundColor = .wanfBackground
    }
}
