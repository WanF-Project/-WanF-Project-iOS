//
//  ClubListTableView.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/15.
//

import UIKit

import RxSwift
import RxCocoa

class ClubListTableView: UITableView {
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    
    //MARK: - Initialize
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero, style: .plain)
        
        configure()
        
        // 임시 데이터
        let cellData = Observable.just(["모임 1", " 모임 2", "모임 3"]).asDriver(onErrorDriveWith: .empty())
        
        cellData
            .drive(self.rx.items(cellIdentifier: "ClubListTableViewCell", cellType: ClubListTableViewCell.self)){ row, element, cell  in
                cell.configureCell(title: element)
                cell.selectionStyle = .none
            }
            .disposed(by: disposeBag)
    }
}

//MARK: - Configure
private extension ClubListTableView {
    func configure() {
        register(ClubListTableViewCell.self, forCellReuseIdentifier: "ClubListTableViewCell")
        self.separatorStyle = .none
        self.rowHeight = 120.0
    }
}
