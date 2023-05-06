//
//  ProfileSingleSelectionListViewController.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/06.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class ProfileSingleSelectionListViewController: UIViewController {
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    
    //MARK: - View
    lazy var doneButton: UIButton = {
        var attributesString = AttributedString("완료")
        attributesString.font = .wanfFont(ofSize: 15, weight: .bold)
        attributesString.foregroundColor = .wanfMint
        
        var configure = UIButton.Configuration.plain()
        configure.attributedTitle = attributesString
        
        return UIButton(configuration: configure)
    }()
    
    lazy var singleSelectionTableView: UITableView = {
        var tableView = UITableView()
        
        tableView.rowHeight = 60
        tableView.separatorStyle = .singleLine
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "singleSelectionListCell")
        
        return tableView
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        layout()
    }
    
    //MARK: - Function
    func bind(_ viewModel: ProfileSingleSelectionListViewModel) {
        
        // 완료 버튼 Tap
        doneButton.rx.tap
            .bind(to: viewModel.doneButtonTapped)
            .disposed(by: disposeBag)
        
        // 아이템 목록 구성
        bindTableView(viewModel)

        //아이템 선택
        singleSelectionTableView.rx.itemSelected
            .bind(to: viewModel.selectedItemIndex)
            .disposed(by: disposeBag)
            
        // 화면 Dismiss
        viewModel.dismissAfterDoneButtonTapped
            .drive (onNext: { _ in
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    func bindTableView(_ viewModel: ProfileSingleSelectionListViewModel) {
        viewModel.cellData
            .drive(singleSelectionTableView.rx.items) { tv, row, element in

                let cell = tv.dequeueReusableCell(withIdentifier: "singleSelectionListCell", for: IndexPath(row: row, section: 0))

                var configuration = UIListContentConfiguration.cell()
                configuration.text = element

                let attributedKey = NSAttributedString.Key.self
                let attributes = [
                    attributedKey.font : UIFont.wanfFont(ofSize: 15, weight: .regular),
                    attributedKey.foregroundColor : UIColor.wanfLabel
                ]
                let attributedTitle = NSAttributedString(string: element, attributes: attributes)

                configuration.attributedText = attributedTitle

                cell.contentConfiguration = configuration

                let backgroundView = UIView()
                backgroundView.backgroundColor = .wanfLightMint

                cell.selectedBackgroundView = backgroundView

                return cell
            }
            .disposed(by: disposeBag)
    }
}

//MARK: - Configure
private extension ProfileSingleSelectionListViewController {
    func configureView() {
        view.backgroundColor = .wanfBackground
    }
    
    func layout() {
        
        [
            doneButton,
            singleSelectionTableView
        ]
            .forEach { view.addSubview($0) }
        
        doneButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(25)
            make.trailing.equalToSuperview().inset(10)
        }
        
        singleSelectionTableView.snp.makeConstraints { make in
            make.top.equalTo(doneButton.snp.bottom).offset(15)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
    }
}
