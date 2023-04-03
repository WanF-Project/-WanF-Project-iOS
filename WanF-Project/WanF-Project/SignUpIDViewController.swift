//
//  SignUpViewController.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/03.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class SignUpIDViewController: UIViewController {
    
    private lazy var nextBarItem: UIBarButtonItem = {
        var item = UIBarButtonItem()
        
        item.image = UIImage(systemName: "arrow.right")
        
        return item
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureView()
        layout()
    }
}

private extension SignUpIDViewController {
    func configureNavigationBar() {
        navigationItem.rightBarButtonItem = nextBarItem
        navigationItem.title = "아이디 설정"
        navigationItem.title = ""
    }
    
    func configureView() {
        view.backgroundColor = .wanfBackground
    }
    
    func layout() {
        
    }
    
}
