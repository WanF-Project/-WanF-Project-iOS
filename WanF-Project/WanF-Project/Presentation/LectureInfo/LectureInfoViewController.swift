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
        
        // View -> ViewModel
        lectureInfoTableView.rx.itemSelected
            .bind(to: viewModel.lectureInfoListItemSelected)
            .disposed(by: disposeBag)
        
        // ViewModel -> View
        bindTableView(viewModel)
        
        viewModel.dismiss
            .drive(onNext: { lectureInfo in
                
                // TODO: - 이전 화면에 강의정보 전달
//                let presentinfVC = self.presentingViewController
//                presentinfVC.lectureInfo = lectureInfo
                
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    func bindTableView(_ viewModel: LectureInfoViewModel) {
        viewModel.cellData
            .drive(lectureInfoTableView.rx.items) { tv, row, element in
                
                let cell = tv.dequeueReusableCell(withIdentifier: "LectureInfoListCell", for: IndexPath(row: row, section: 0))
                
                var configuration = UIListContentConfiguration.valueCell()
                configuration.text = element.lectureName
                configuration.secondaryText = element.professorName
                
                let attributedKey = NSAttributedString.Key.self
                let attributes = [
                    attributedKey.font : UIFont.wanfFont(ofSize: 15, weight: .regular),
                    attributedKey.foregroundColor : UIColor.wanfLabel
                ]
                let attributedTitle = NSAttributedString(string: element.lectureName, attributes: attributes)
                let attributedSubtitle = NSAttributedString(string: element.professorName, attributes: attributes)
                
                configuration.attributedText = attributedTitle
                configuration.secondaryAttributedText = attributedSubtitle
                
                cell.contentConfiguration = configuration
                
                let backgroundView = UIView()
                backgroundView.backgroundColor = .wanfLightMint
                
                cell.selectedBackgroundView = backgroundView
                
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

