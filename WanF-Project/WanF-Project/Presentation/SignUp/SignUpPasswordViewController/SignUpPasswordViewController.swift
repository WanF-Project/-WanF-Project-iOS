//
//  SignUpPasswordViewController.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/04.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class SignUpPasswordViewController: UIViewController {
    
    let disposebag = DisposeBag()
    
    private lazy var preBarItem: UIBarButtonItem = {
        var item = UIBarButtonItem()
        
        item.image = UIImage(systemName: "chevron.backward")
        
        return item
    }()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        
        tableView.backgroundColor = .wanfBackground
        tableView.separatorStyle = .none
        tableView.rowHeight = 60
        
        tableView.register(PasswordTextFieldCell.self, forCellReuseIdentifier: "PasswordTextFieldCell")
        tableView.register(PasswordToCheckTextFieldCell.self, forCellReuseIdentifier: "PasswordToCheckTextFieldCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AlertMessageCell")
        
        return tableView
    }()
    
    private lazy var doneBarItem: UIBarButtonItem = {
        var item = UIBarButtonItem()
        
        item.title = "완료"
        
        return item
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureView()
        layout()
    }
    
    func bind(_ viewModel: SignUpPasswordViewModel) {
        viewModel.cellData
            .drive(tableView.rx.items) { tv, row, element in
                switch row {
                case 0:
                    guard let cell = tv.dequeueReusableCell(withIdentifier: "PasswordTextFieldCell", for: IndexPath(row: row, section: 0)) as? PasswordTextFieldCell else { return UITableViewCell() }
                    
                    cell.selectionStyle = .none
                    
                    return cell
                case 1:
                    guard let cell = tv.dequeueReusableCell(withIdentifier: "PasswordToCheckTextFieldCell", for: IndexPath(row: row, section: 0)) as? PasswordToCheckTextFieldCell else { return UITableViewCell() }
                    
                    cell.selectionStyle = .none
                    
                    return cell
                case 2:
                    let cell = tv.dequeueReusableCell(withIdentifier: "AlertMessageCell", for: IndexPath(row: row, section: 0))
                    
                    let attributes = [
                        NSAttributedString.Key.font : UIFont.wanfFont(ofSize: 15, weight: .regular),
                        NSAttributedString.Key.foregroundColor : UIColor.orange
                    ]
                    let attributedText = NSAttributedString(string: "인증번호 안내 문구",attributes: attributes)
                    
                    var configuration = UIListContentConfiguration.cell()
                    configuration.attributedText = attributedText
                    
                    cell.contentConfiguration = configuration
                    cell.selectionStyle = .none
                    
                    return cell
                default:
                    return UITableViewCell()
                }
            }
            .disposed(by: disposebag)
    }
}

private extension SignUpPasswordViewController {
    func configureNavigationBar() {
        navigationItem.title = "비밀번호 설정"
        navigationItem.leftBarButtonItem = preBarItem
        navigationItem.rightBarButtonItem = doneBarItem
    }
    
    func configureView() {
        view.backgroundColor = .wanfBackground
        
        [ tableView ].forEach { view.addSubview($0) }
    }
    
    func layout() {
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.horizontalEdges.bottom.equalToSuperview().inset(20)
        }
    }
}
