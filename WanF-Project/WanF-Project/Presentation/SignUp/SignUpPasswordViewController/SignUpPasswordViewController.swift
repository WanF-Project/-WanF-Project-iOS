//
//  SignUpPasswordViewController.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/04.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class SignUpPasswordViewController: UIViewController {
    
    let disposebag = DisposeBag()
    
    private lazy var preBarItem: UIBarButtonItem = {
        var item = UIBarButtonItem()
        
        item.image = UIImage(systemName: "chevron.backward")
        
        return item
    }()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        
        tableView.backgroundColor = .wanfBackground
        tableView.separatorStyle = .none
        tableView.rowHeight = 60
        
        tableView.register(EmailStackViewCell.self, forCellReuseIdentifier: "EmailStackViewCell")
        tableView.register(VerifiedStackViewCell.self, forCellReuseIdentifier: "VerifiedStackViewCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AlertMessageCell")
        
        return tableView
    }()
    
    private lazy var doneBarItem: UIBarButtonItem = {
        var item = UIBarButtonItem()
        
        item.title = "완료"
        
        return item
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureView()
        layout()
    }
}

private extension SignUpPasswordViewController {
    func configureNavigationBar() {
        navigationItem.title = "비밀번호 설정"
        navigationItem.leftBarButtonItem = preBarItem
        navigationItem.rightBarButtonItem = doneBarItem
    }
    
    func configureView() {
        view.backgroundColor = .wanfBackground
    }
    
    func layout() {
        
    }
}
