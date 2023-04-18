//
//  FriendsMatchDetailViewController.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/11.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class FriendsMatchDetailViewController: UIViewController {
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    
    //MARK: - View
    private lazy var detailInfoView = FriendsMatchDetailInfoView()
    private lazy var lectureInfoView = FriendsMatchDetailLectureInfoView()
    private lazy var detailTextView = FriendsMatchDetailTextView()
    
    private lazy var menuBarItem: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(systemName: "ellipsis"))
    }()
    
    private lazy var scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        
        return scrollView
    }()
    
    private lazy var contentView = UIView()
    
    private lazy var DetailStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [detailInfoView, lectureInfoView, detailTextView])
        
        stackView.axis = .vertical
        stackView.spacing = 28.0
        
        return stackView
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        layout()
    }
    
    //MARK: - Function
    func bind(_ viewModel: FriendsMatchDetailViewModel){
        
        // Bind SubComponent
        detailInfoView.bind(viewModel.detailInfoViewModel)
        lectureInfoView.bind(viewModel.lectureInfoViewModel)
        detailTextView.bind(viewModel.detailTextViewModel)
        
        // Load the Detail Data
        viewModel.shouldLoadDetail.onNext(Void())
        
    }
}

//MARK: - Configure
private extension FriendsMatchDetailViewController {
    
    func configureView() {
        view.backgroundColor = .wanfBackground
        
        navigationItem.rightBarButtonItem = menuBarItem
    }
    
    func layout() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        [
            DetailStackView
        ]
            .forEach { contentView.addSubview($0) }
        
        let verticalInset = 30.0
        let horizontalInset = 20.0
        
        scrollView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(verticalInset)
            make.horizontalEdges.equalToSuperview().inset(horizontalInset)
            make.width.equalTo(scrollView.snp.width).inset(horizontalInset)
        }
        
        DetailStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalToSuperview()
        }
        
        
    }
}
