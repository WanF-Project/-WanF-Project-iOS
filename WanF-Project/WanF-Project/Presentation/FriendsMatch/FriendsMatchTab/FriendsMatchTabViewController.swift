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
    
    lazy var friednsMatchTableView = FriendsMatchTableView()
    
    lazy var refreshControl = UIRefreshControl()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        layout()
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
        
        friednsMatchTableView.rx.itemSelected
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
        
        bindTableView(viewModel)
    }
    
    func bindTableView(_ viewModel: FriendsMatchTabViewModel) {
        viewModel.cellData
            .drive(friednsMatchTableView.rx.items) { tv, row, element in
                guard let cell = tv.dequeueReusableCell(withIdentifier: "FriendsMatchListCell", for: IndexPath(row: row, section: 0)) as? FriendsMatchListCell else { return UITableViewCell() }
                
                cell.selectionStyle = .none
                cell.setCellData(element)
                
                return cell
            }
            .disposed(by: disposeBag)
    }
}
private extension FriendsMatchTabViewController {
    func configureView() {
        view.backgroundColor = .wanfBackground
        
        navigationItem.title = "강의 친구 찾기"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.wanfLabel,
            NSAttributedString.Key.font : UIFont.wanfFont(ofSize: 15, weight: .bold)
        ]
        
        navigationController?.navigationBar.tintColor = .wanfMint
        navigationItem.leftBarButtonItem = profileBarItem
        navigationItem.rightBarButtonItems = [addBarItem, searchBarItem]
    }
    
    func layout() {
        friednsMatchTableView.refreshControl = refreshControl
        
        view.addSubview(friednsMatchTableView)
        
        friednsMatchTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
    }
}
