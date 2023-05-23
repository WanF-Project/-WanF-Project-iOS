//
//  FriendsMatchCommentListView.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/16.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class FriendsMatchCommentListView: DynamicSizeTableView {
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    
    //MARK: - LifeCycle
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        register(UITableViewCell.self, forCellReuseIdentifier: "FriendsMatchCommentListCell")
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //MARK: - Function
    func bind(_ viewModel: FriendsMatchCommentListViewModel) {
        
        bindTableView(viewModel)
    }
    
    func bindTableView(_ viewModel: FriendsMatchCommentListViewModel) {
        viewModel.cellData
            .drive(self.rx.items(cellIdentifier: "FriendsMatchCommentListCell")) { row, element, cell in
                var configuration = UIListContentConfiguration.subtitleCell()
                
                let attributedKey = NSAttributedString.Key.self
                let attributesForTitle = [
                    attributedKey.font : UIFont.wanfFont(ofSize: 15, weight: .bold),
                    attributedKey.foregroundColor : UIColor.wanfLabel
                ]
                let attributesForSubtitle = [
                    attributedKey.font : UIFont.wanfFont(ofSize: 15, weight: .regular),
                    attributedKey.foregroundColor : UIColor.wanfLabel
                ]
                
                let attributedTitle = NSAttributedString(string: element.profile.nickname ?? "별명", attributes: attributesForTitle)
                let attributedSubtitle = NSAttributedString(string: element.content, attributes: attributesForSubtitle)
                
                configuration.attributedText = attributedTitle
                configuration.secondaryAttributedText = attributedSubtitle
                configuration.textToSecondaryTextVerticalPadding = 5.0
                configuration.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0)
                
                cell.contentConfiguration = configuration
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                
            }
            .disposed(by: disposeBag)
    }
}

//MARK: - Configure
private extension FriendsMatchCommentListView {
    func configureView() {
        backgroundColor = .wanfBackground
        isScrollEnabled = false
        separatorStyle = .singleLine
    }
}
