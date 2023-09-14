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
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    
    //MARK: - View
    private lazy var friendsMatchVC: FriendsMatchTabViewController = {
        let viewController = FriendsMatchTabViewController()
        
        let item = UITabBarItem(title: "친구 찾기", image: UIImage(systemName: "person.2.fill"), tag: 0)
        viewController.tabBarItem = item
        
        return viewController
    }()
    
    private lazy var randomFriendsVC: RandomFriendsViewController = {
        let viewController = RandomFriendsViewController()
        let item = UITabBarItem(title: "랜덤 친구", image: UIImage(systemName: "dice.fill"), tag: 1)
        
        viewController.tabBarItem = item
        
        return viewController
    }()
    
    private lazy var clubListVC: ClubListViewController = {
        let viewController = ClubListViewController()
        
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
        
        // Bind Subcomponents
        friendsMatchVC.bind(viewModel.friendsMaychViewModel)
        randomFriendsVC.bind(viewModel.randomFriendsViewModel)
        clubListVC.bind(viewModel.clubViewModel)
        messageListVC.bind(viewModel.messageListViewModel)
        
        // ViewModel -> View
        viewModel.selectedTab
            .drive(onNext: { type in
                var tag: Int = 0
                
                switch type {
                case .friends:
                    tag = self.friendsMatchVC.tabBarItem.tag
                case .randomFriends:
                    tag = self.randomFriendsVC.tabBarItem.tag
                case .clubs:
                    tag = self.clubListVC.tabBarItem.tag
                case .messages:
                    tag = self.messageListVC.tabBarItem.tag
                }
                
                self.selectedIndex = tag
            })
            .disposed(by: disposeBag)
        
        
    }
}

//MARK: - Configure
private extension MainTabBarController {
    func configureView() {
        view.backgroundColor = .wanfBackground
        
        tabBar.tintColor = .wanfGray
        self.viewControllers = [
            UINavigationController(rootViewController: friendsMatchVC),
            UINavigationController(rootViewController: randomFriendsVC),
            UINavigationController(rootViewController: clubListVC),
            UINavigationController(rootViewController: messageListVC)
        ]
    }
}
