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
    var viewModel: FriendsMatchDetailViewModel?
    
    //MARK: - View
    private lazy var detailInfoView = FriendsMatchDetailInfoView()
    private lazy var lectureInfoView = FriendsMatchDetailLectureInfoView()
    private lazy var detailTextView = FriendsMatchDetailTextView()
    private lazy var commentListView = FriendsMatchCommentListView()
    
    lazy var midBarView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .wanfMint
        
        return view
    }()
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        adjustContentViewSize()
    }
    
    //MARK: - Function
    func bind(_ viewModel: FriendsMatchDetailViewModel){
        
        self.viewModel = viewModel
        
        // Load a Detail
        viewModel.loadFriendsMatchDetail.accept(Void())
        
        // Bind SubComponent
        detailInfoView.bind(viewModel.detailInfoViewModel)
        lectureInfoView.bind(viewModel.lectureInfoViewModel)
        detailTextView.bind(viewModel.detailTextViewModel)
        commentListView.bind(viewModel.commentListViewModel)
        
        // MenueButton Action
        menuBarItem.rx.tap
            .bind(to: viewModel.menueButtonTapped)
            .disposed(by: disposeBag)
        
        viewModel.presentMenueActionSheet
            .emit(to: self.rx.presentMenueActionSheet)
            .disposed(by: disposeBag)
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
            DetailStackView,
            midBarView,
            commentListView
        ]
            .forEach { contentView.addSubview($0) }
        
        let verticalInset = 30.0
        let horizontalInset = 20.0
        let offset = 15.0
        
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
            make.top.equalToSuperview()
        }
        
        
        midBarView.snp.makeConstraints { make in
            make.top.equalTo(DetailStackView.snp.bottom).offset(offset * 2)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1.0)
            
        }
        
        commentListView.snp.makeConstraints { make in
            make.top.equalTo(midBarView.snp.bottom).offset(offset)
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    func adjustContentViewSize() {
        let contentHeight = contentView.frame.height + commentListView.frame.height
        contentView.frame.size = CGSize(
            width: contentView.frame.width,
            height: contentHeight
        )
        scrollView.contentSize = contentView.frame.size
    }
}

extension Reactive where Base: FriendsMatchDetailViewController {
    var presentMenueActionSheet: Binder<Void> {
        return Binder(base) { base, _ in
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel)
            
            // TODO: - 추후 수정 기능 구현
//            let editAction = UIAlertAction(title: "수정", style: .default) { _ in
//                print("Present FriendsMatchWritingEntity")
//            }
            
            let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
                if base.viewModel != nil {
                    base.viewModel!.deleteButtonTapped
                        .subscribe()
                        .disposed(by: base.disposeBag)
                    
                    base.viewModel!.popToRootViewController
                        .drive(onNext: { _ in
                            base.navigationController?.popToRootViewController(animated: true)
                        })
                        .disposed(by: base.disposeBag)
                }
            }
            
            [
                cancelAction,
//                editAction,
                deleteAction
            ]
                .forEach { actionSheet.addAction($0) }
            
            base.present(actionSheet, animated: true)
        }
    }
}
