//
//  RandomFriendsViewController.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/14.
//

import UIKit

class RandomFriendsViewController: UIViewController {
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    func bind(_ viewModel: RandomFriendsViewModel) {
        
    }
}

private extension RandomFriendsViewController {
    func configure() {
        view.backgroundColor = .wanfBackground
    }
}
