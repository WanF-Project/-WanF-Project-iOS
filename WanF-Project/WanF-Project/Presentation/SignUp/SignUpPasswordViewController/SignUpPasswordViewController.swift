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
    
    //MARK: - Properties
    let disposebag = DisposeBag()
    
    //MARK: - View
    private lazy var preBarItem: UIBarButtonItem = {
        var item = UIBarButtonItem()
        
        item.image = UIImage(systemName: "chevron.backward")
        
        return item
    }()
    
    lazy var tableView: UITableView = {
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
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureView()
        layout()
    }
    
    //MARK: - Function
    func bind(_ viewModel: SignUpPasswordViewModel) {
        
        // View -> ViewModel
        
        // ViewModel -> View
        viewModel.showGuidance
            .emit(to: self.rx.showGuidance)
            .disposed(by: disposebag)
        
        viewModel.cellData
            .drive(tableView.rx.items) { tv, row, element in
                switch row {
                case 0:
                    guard let cell = tv.dequeueReusableCell(withIdentifier: "PasswordTextFieldCell", for: IndexPath(row: row, section: 0)) as? PasswordTextFieldCell else { return UITableViewCell() }
                    
                    cell.bind(viewModel.passwordTextFieldCellViewModel)
                    cell.selectionStyle = .none
                    
                    return cell
                case 1:
                    guard let cell = tv.dequeueReusableCell(withIdentifier: "PasswordToCheckTextFieldCell", for: IndexPath(row: row, section: 0)) as? PasswordToCheckTextFieldCell else { return UITableViewCell() }
                    
                    cell.bind(viewModel.passwordToCheckTextFieldCellViewModel)
                    cell.selectionStyle = .none
                    
                    return cell
                case 2:
                    let cell = tv.dequeueReusableCell(withIdentifier: "AlertMessageCell", for: IndexPath(row: row, section: 0))
                    
                    let attributes = [
                        NSAttributedString.Key.font : UIFont.wanfFont(ofSize: 15, weight: .regular),
                        NSAttributedString.Key.foregroundColor : UIColor.orange
                    ]
                    let attributedText = NSAttributedString(string: "비밀번호가 일치하지 않습니다.",attributes: attributes)
                    
                    var configuration = UIListContentConfiguration.cell()
                    configuration.attributedText = attributedText
                    
                    cell.contentConfiguration = configuration
                    cell.isHidden = true
                    cell.selectionStyle = .none
                    
                    return cell
                default:
                    return UITableViewCell()
                }
            }
            .disposed(by: disposebag)
    }
}

//MARK: - Configure
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

extension Reactive where Base: SignUpPasswordViewController {
    var showGuidance: Binder<Bool> {
        return Binder(base) { base, isShown in
            guard let cell = base.tableView.cellForRow(at: IndexPath(row: 2, section: 0 )) else { return }
            cell.isHidden = !isShown
        }
    }
}
