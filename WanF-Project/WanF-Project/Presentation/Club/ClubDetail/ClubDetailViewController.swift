//
//  ClubDetailViewController.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/22.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class ClubDetailViewController: UIViewController {
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    
    //MARK: - View
    let addBarItem = AddBarButtonItem()
    let postTableview: UITableView = {
        var tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(ClubDetailTableViewCell.self, forCellReuseIdentifier: "ClubDetailTableViewCell")
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        layout()
    }
    
    func bind(_ viewModel: ClubDetailViewModel) {
        viewModel.cellData
            .drive(postTableview.rx.items(cellIdentifier: "ClubDetailTableViewCell", cellType: ClubDetailTableViewCell.self)) { row, element, cell in
                cell.bind(viewModel.cellViewModel)
                cell.configureCell(element)
                cell.selectionStyle = .none
            }
            .disposed(by: disposeBag)
    }
}

private extension ClubDetailViewController {
    func configure() {
        view.backgroundColor = .wanfBackground
        view.addSubview(postTableview)
        
        navigationItem.rightBarButtonItem = addBarItem
        
    }
    
    func layout() {
        postTableview.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

