//
//  FriendsMatchViewController.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/09.
//

import UIKit

import RxSwift
import RxCocoa

class FriendsMatchViewController: UIViewController {
    
    //MARK: - View
    private lazy var profileBarItem: UIBarButtonItem = {
        let item = UIBarButtonItem()
        
        item.image = UIImage(systemName: "person.crop.circle.fill")
        
        return item
    }()
    
    private lazy var addBarItem: UIBarButtonItem = {
        let item = UIBarButtonItem()
        
        item.image = UIImage(systemName: "plus")
        
        return item
    }()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .wanfBackground
        configureView()
    }
}
private extension FriendsMatchViewController {
    func configureView() {
        
        navigationItem.title = "수업 친구 찾기"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.wanfLabel,
            NSAttributedString.Key.font : UIFont.wanfFont(ofSize: 15, weight: .bold)
        ]
        
        navigationController?.navigationBar.tintColor = .wanfMint
        navigationItem.leftBarButtonItem = profileBarItem
        navigationItem.rightBarButtonItem = addBarItem
    }
}
