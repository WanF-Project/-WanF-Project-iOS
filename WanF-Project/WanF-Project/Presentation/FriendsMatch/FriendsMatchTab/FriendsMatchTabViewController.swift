//
//  FriendsMatchViewController.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/09.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class FriendsMatchTabViewController: UIViewController {
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    
    //MARK: - View
    private lazy var profileBarItem = ProfileBarButtonItem()
    
    private lazy var searchBarItem: UIBarButtonItem = {
        let item = UIBarButtonItem()
        item.image = UIImage(systemName: "magnifyingglass")
        return item
    }()
    
    private lazy var addBarItem = AddBarButtonItem()
    
    lazy var friednsMultipleListView = FriendsMultipleListView([.bannerSection, .postSection])
    
    lazy var refreshControl = UIRefreshControl()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    //MARK: - Function {
    func bind(_ viewModel: FriendsMatchTabViewModel) {
        
        // Load a list
        viewModel.loadFriendsMatchList.onNext(Void())
        
        // Refresh the list
        refreshControl.rx.controlEvent(.valueChanged)
            .bind {[weak self] _ in
                viewModel.subject.onNext(viewModel.refreshFriendsMatchList)
                viewModel.refreshFriendsMatchList.onNext(Void())
                self?.refreshControl.endRefreshing()
            }
            .disposed(by: disposeBag)
        
        // View -> ViewModel
        profileBarItem.rx.tap
            .bind(to: viewModel.profileButtonTapped)
            .disposed(by: disposeBag)
        
        searchBarItem.rx.tap
            .bind(to: viewModel.searchButtonTapped)
            .disposed(by: disposeBag)
        
        addBarItem.rx.tap
            .bind(to: viewModel.addButtonTapped)
            .disposed(by: disposeBag)
        
        friednsMultipleListView.rx.itemSelected
            .map {
                viewModel.loadDetailSubject.onNext(viewModel.loadDetailForSelectedItem)
                return $0.row
            }
            .bind(to: viewModel.didSelectItem)
            .disposed(by: disposeBag)
        
        // ViewModel -> View
        viewModel.pushToProfile
            .drive(onNext: { viewModel in
                let profileVC = ProfileMainViewController()
                profileVC.bind(viewModel)
                
                self.navigationController?.pushViewController(profileVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.pushToFriendsMatchDetail
            .drive(onNext: { viewModel in
                let friendsMatchDetailVC = FriendsMatchDetailViewController()
                friendsMatchDetailVC.bind(viewModel)
                
                self.navigationController?.pushViewController(friendsMatchDetailVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.pushToSearch
            .drive(onNext: { viewModel in
                let searchVC = FriendsMatchSearchViewController()
                searchVC.bind(viewModel)
                
                self.navigationController?.pushViewController(searchVC, animated: true)
            })
            .disposed(by: disposeBag)
            
        
        viewModel.presentFriendsMatchWriting
            .drive(onNext: { viewModel in
                let friendsMatchWritingVC = FriendsMatchWritingViewController()
                friendsMatchWritingVC.bind(viewModel)
                friendsMatchWritingVC.modalPresentationStyle = .fullScreen
                
                self.present(friendsMatchWritingVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        bindListView(viewModel)
    }
    
    func bindListView(_ viewModel: FriendsMatchTabViewModel) {
        viewModel.multipleCellData
            .drive(friednsMultipleListView.rx.items(dataSource: dataSource()))
            .disposed(by: disposeBag)
    }
}
private extension FriendsMatchTabViewController {
    func configureNavigationBar() {
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .wanfMint
        
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.tintColor = .wanfBackground
        
        let logo = UIBarButtonItem(title: "Wan.F")
        let attributes = [ NSAttributedString.Key.font : UIFont.wanfLogoFont(ofSize: 30.0) ]
        logo.setTitleTextAttributes(attributes, for: .normal)
        
        navigationItem.leftBarButtonItem = logo
        navigationItem.rightBarButtonItems = [profileBarItem, searchBarItem, addBarItem]
    }
    
    func configureView() {
        view.backgroundColor = .wanfBackground
    }
    
    func layout() {
        friednsMultipleListView.refreshControl = refreshControl
        
        view.addSubview(friednsMultipleListView)
        
        friednsMultipleListView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
