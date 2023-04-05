//
//  MainTabBarController.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/04.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .wanfBackground
    }
    
    func bind(_ viewModel: MainTabBarViewModel) {
        
    }
}
