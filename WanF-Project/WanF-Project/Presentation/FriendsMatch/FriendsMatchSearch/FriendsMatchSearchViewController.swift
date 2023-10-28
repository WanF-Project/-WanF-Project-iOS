//
//  FriendsMatchSearchViewController.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/07/30.
//

import UIKit

import RxSwift
import RxCocoa

class FriendsMatchSearchViewController: UIViewController {
    
    //MARK: - Propertise
    let disposeBag = DisposeBag()
    
    //MARK: - View
    let searchBar = CSSearchBarView()
    let postListView = FriendsMultipleListView()
    
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
    
    //MARK: - Function
    func bind(_ viewModel: FriendsMatchSearchViewModel) {
        
        // Bind Subcomponent
        searchBar.bind(viewModel.searchBarViewModel)
        
        // Configure list
        viewModel.cellData
            .drive(postListView.rx.items(cellIdentifier: "FriendsMatchListCell", cellType: FriendsMatchListCell.self)){ row, element, cell in
                cell.configureCell(element)
            }
            .disposed(by: disposeBag)
        
        // Select Item
        postListView.rx.itemSelected
            .bind(to: viewModel.didSelectItem)
            .disposed(by: disposeBag)
        
        // Push To Detail
        viewModel.pushToDetail
            .drive(onNext: { viewModel in
                let friendsMatchDetailVC = FriendsMatchDetailViewController()
                friendsMatchDetailVC.bind(viewModel)
                self.navigationController?.pushViewController(friendsMatchDetailVC, animated: true)
            })
            .disposed(by: disposeBag)
            
        
    }
}

//MARK: - Configure
private extension FriendsMatchSearchViewController {
    
    func configureNavigationBar() {
        navigationItem.title = "게시글 검색"
        let textAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.wanfLabel,
            NSAttributedString.Key.font : UIFont.wanfFont(ofSize: 15, weight: .bold)
        ]
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = textAttributes
        appearance.backgroundColor = .wanfBackground
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.tintColor = .wanfMint
    }
    
    func configureView() {
        self.view.backgroundColor = .wanfBackground
        searchBar.placeholder = "강의명을 입력하세요"
        
        [
            searchBar,
            postListView
        ]
            .forEach { view.addSubview($0) }
    }
    
    func layout() {
        
        let inset: CGFloat = 15.0
        let offset: CGFloat = 15.0
        
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(inset/3)
        }
        
        postListView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
