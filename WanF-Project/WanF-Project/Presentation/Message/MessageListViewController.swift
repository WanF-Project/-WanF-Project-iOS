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
    func configure() {
        view.backgroundColor = .wanfBackground
    }
}
