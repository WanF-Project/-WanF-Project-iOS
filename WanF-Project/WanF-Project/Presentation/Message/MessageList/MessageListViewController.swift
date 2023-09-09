//
//  MessageListViewController.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/01.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class MessageListViewController: UIViewController {
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    
    //MARK: - View
    lazy var tableView = UITableView(frame: .zero)
    lazy var refreshControl = UIRefreshControl()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        layout()
    }
    
    //MARK: - Function
    func bind(_ viewModel: MessageListViewModel) {
        // View -> ViewModel
        viewModel.loadMessageList.onNext(Void())
        
        refreshControl.rx.controlEvent(.valueChanged)
            .bind(onNext: {
                viewModel.loadListSubject.onNext(viewModel.refreshMessageList)
                viewModel.refreshMessageList.onNext($0)
                self.refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .map {
                viewModel.loadDetailSubject.onNext(viewModel.loadDetailForSelectedItem)
                return $0.row
            }
            .bind(to: viewModel.didSelectItem)
            .disposed(by: disposeBag)
        
        // ViewModel -> View
        viewModel.cellData
            .drive(tableView.rx.items(cellIdentifier: "MessageListViewCell")) { row, element, cell in
                let attributedKey = NSAttributedString.Key.self
                let attributes = [
                    attributedKey.foregroundColor : UIColor.wanfLabel,
                    attributedKey.font : UIFont.wanfFont(ofSize: 15, weight: .bold)
                ]
                let attributedString = NSAttributedString(string: element.nickname, attributes: attributes)

                var configuration = UIListContentConfiguration.cell()
                configuration.attributedText = attributedString

                var accessoryView = UIImageView(image: UIImage(systemName: "chevron.right"))
                accessoryView.tintColor = .wanfMint
                
                cell.selectionStyle = .none
                cell.contentConfiguration = configuration
                cell.accessoryView = accessoryView
            }
            .disposed(by: disposeBag)
        
        viewModel.pushToMessageDetail
            .drive(onNext: { viewModel in
                let messageDetailVC = MessageDetailViewController()
                messageDetailVC.bind(viewModel)
                self.navigationController?.pushViewController(messageDetailVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

//MARK: - Configure
extension MessageListViewController {
    
    func configureNavigationBar() {
        navigationItem.title = "쪽지 목록"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.wanfLabel,
            NSAttributedString.Key.font : UIFont.wanfFont(ofSize: 15, weight: .bold)
        ]
        navigationController?.navigationBar.tintColor = .wanfMint
    }
    
    func configure() {
        configureNavigationBar()
        view.backgroundColor = .wanfBackground
        tableView.refreshControl = refreshControl
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MessageListViewCell")
        tableView.rowHeight = 60
        view.addSubview(tableView)
    }
    
    func layout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
