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
    
    //MARK: - View
    private lazy var friendsMatchVC: FriendsMatchTabViewController = {
        let viewController = FriendsMatchTabViewController()
        
        let item = UITabBarItem(title: "친구 찾기", image: UIImage(systemName: "person.2.fill"), tag: 0)
        viewController.tabBarItem = item
        
        return viewController
    }()
    
    private lazy var classInfoVC: UINavigationController = {
        let viewController = UINavigationController(rootViewController: ClassInfoViewController())
        let item = UITabBarItem(title: "수업 정보", image: UIImage(systemName: "info.square.fill"), tag: 1)
        
        viewController.tabBarItem = item
        
        return viewController
    }()
    
    private lazy var clubListVC: ClubListViewController = {
        let viewController = ClubListViewController()
        let viewModel = ClubListViewModel()
        viewController.bind(viewModel)
        
        let item = UITabBarItem(title: "강의 모임", image: UIImage(systemName: "rectangle.3.group.bubble.left.fill"), tag: 2)
        
        viewController.tabBarItem = item
        
        return viewController
    }()
    
    private lazy var messageListVC: MessageListViewController = {
        let viewController = MessageListViewController()
        
        let item = UITabBarItem(title: "쪽지", image: UIImage(systemName: "ellipsis.message.fill"), tag: 3)
        viewController.tabBarItem = item
        
        return viewController
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    //MARK: - Function
    func bind(_ viewModel: MainTabBarViewModel) {
        friendsMatchVC.bind(viewModel.friendsMaychViewModel)
        messageListVC.bind(viewModel.messageListViewModel)
    }
}

//MARK: - Configure
private extension MainTabBarController {
    func configureView() {
        view.backgroundColor = .wanfBackground
        
        tabBar.tintColor = .wanfGray
        self.viewControllers = [
            UINavigationController(rootViewController: friendsMatchVC),
            UINavigationController(rootViewController: clubListVC),
            UINavigationController(rootViewController: messageListVC)
        ]
    }
}
