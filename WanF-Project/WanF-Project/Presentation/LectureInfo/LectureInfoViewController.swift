//
//  LectureInfoViewController.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/15.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class LectureInfoViewController: UIViewController {
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    
    //MARK: - View
    lazy var lectureInfoTableView: UITableView = {
        var tableView = UITableView()
        
        tableView.rowHeight = 60
        tableView.separatorStyle = .singleLine
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LectureInfoListCell")
        
        return tableView
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        layout()
    }
    
    //MARK: - Function
    func bind(_ viewModel: LectureInfoViewModel) {
     
        bindTableView(viewModel)
    }
    
    func bindTableView(_ viewModel: LectureInfoViewModel) {
        viewModel.cellData
            .drive(lectureInfoTableView.rx.items) { tv, row, element in
                
                let cell = tv.dequeueReusableCell(withIdentifier: "LectureInfoListCell", for: IndexPath(row: row, section: 0))
                
                return cell
            }
            .disposed(by: disposeBag)
    }
}

private extension LectureInfoViewController {
    func configureView() {
        view.backgroundColor = .wanfBackground
    }
    
    func layout() {
        view.addSubview(lectureInfoTableView)
        
        lectureInfoTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
    }
}

