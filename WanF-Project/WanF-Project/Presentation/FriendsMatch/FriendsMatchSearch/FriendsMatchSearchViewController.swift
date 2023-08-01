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
    let postTableView = FriendsMatchTableView()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        layout()
    }
    
    //MARK: - Function
    func bind(_ viewModel: FriendsMatchSearchViewModel) {
        
        // 임시 데이터
        let posts = [
            PostListResponseEntity(id: 0, title: "테스트1", course: CourseEntity(id: 0, name: "강의명1", professor: "교수명1")),
            PostListResponseEntity(id: 0, title: "테스트2", course: CourseEntity(id: 0, name: "강의명2", professor: "교수명2"))
        ]
        Driver.just(posts)
            .drive(postTableView.rx.items(cellIdentifier: "FriendsMatchListCell", cellType: FriendsMatchListCell.self)){ row, element, cell in
                cell.selectionStyle = .none
                cell.setCellData(element)
            }
            .disposed(by: disposeBag)
            
        
    }
}

//MARK: - Configure
private extension FriendsMatchSearchViewController {
    func configureView() {
        self.view.backgroundColor = .wanfBackground
        searchBar.placeholder = "강의명을 입력하세요"
        
        [
            searchBar,
            postTableView
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
        
        postTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(offset)
            make.horizontalEdges.equalToSuperview().inset(offset)
            make.bottom.equalToSuperview().inset(inset)
        }
    }
}
