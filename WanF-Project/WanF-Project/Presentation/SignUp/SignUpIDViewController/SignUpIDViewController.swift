//
//  SignUpViewController.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/03.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class SignUpIDViewController: UIViewController {
    
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
        
        tableView.register(EmailStackViewCell.self, forCellReuseIdentifier: "EmailStackViewCell")
        tableView.register(VerifiedStackViewCell.self, forCellReuseIdentifier: "VerifiedStackViewCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AlertMessageCell")
        
        return tableView
    }()
    
    private lazy var nextBarItem: UIBarButtonItem = {
        var item = UIBarButtonItem()
        
        item.title = "다음"
        
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
    func bind(_ viewModel: SignUpIDViewModel) {
        
        // View -> ViewModel
        
        // ViewModel -> View
        
        viewModel.showGuidance
            .emit(to: self.rx.showGuidance)
            .disposed(by: disposebag)
        
        viewModel.cellData
            .drive(tableView.rx.items) { tv, row, element in
                switch row {
                case 0:
                    guard let cell = tv.dequeueReusableCell(withIdentifier: "EmailStackViewCell", for: IndexPath(row: row, section: 0)) as? EmailStackViewCell else { return UITableViewCell() }
                    
                    cell.selectionStyle = .none
                    cell.bind(viewModel.emailStackViewCellViewModel)
                    
                    return cell
                case 1:
                    guard let cell = tv.dequeueReusableCell(withIdentifier: "VerifiedStackViewCell", for: IndexPath(row: row, section: 0)) as? VerifiedStackViewCell else { return UITableViewCell() }
                    
                    cell.selectionStyle = .none
                    
                    return cell
                case 2:
                    let cell = tv.dequeueReusableCell(withIdentifier: "AlertMessageCell", for: IndexPath(row: row, section: 0))
                    
                    let attributes = [
                        NSAttributedString.Key.font : UIFont.wanfFont(ofSize: 15, weight: .regular),
                        NSAttributedString.Key.foregroundColor : UIColor.orange
                    ]
                    let attributedText = NSAttributedString(string: "인증번호 유효시간은 30분입니다.",attributes: attributes)
                    
                    var configuration = UIListContentConfiguration.cell()
                    configuration.attributedText = attributedText
                    
                    cell.contentConfiguration = configuration
                    cell.selectionStyle = .none
                    cell.isHidden = true
                    
                    return cell
                default:
                    return UITableViewCell()
                }
            }
            .disposed(by: disposebag)
    }
}

//MARK: - Configure
private extension SignUpIDViewController {
    func configureNavigationBar() {
        navigationItem.leftBarButtonItem = preBarItem
        navigationItem.rightBarButtonItem = nextBarItem
        navigationItem.title = "아이디 설정"
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

extension Reactive where Base: SignUpIDViewController {
    var showGuidance: Binder<Bool> {
        return Binder(base) { base, isShown in
            guard let cell = base.tableView.cellForRow(at: IndexPath(row: 2, section: 0)) else { return }
            cell.isHidden = !isShown
        }
    }
}
