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
    
    private lazy var commentAddButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "plus")
        configuration.baseForegroundColor = .wanfMint
        configuration.baseBackgroundColor = .wanfBackground
        
        var background = UIBackgroundConfiguration.clear()
        background.cornerRadius = 25
        background.strokeColor = .wanfMint
        background.strokeWidth = 1.5
        
        configuration.background = background
        
        var button = UIButton(configuration: configuration)
        button.layer.shadowColor = UIColor.wanfGray.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.shadowOpacity = 0.7
        
        return button
    }()
    
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
        configureGesture()
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
        
        // Present ProfilePreview
        viewModel.presentProfilePreview
            .drive(onNext: { id in
                let profileProviewVC = ProfilePreviewViewController()
                profileProviewVC.bind(ProfilePreviewViewModel(), id: id)
                
                self.present(profileProviewVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        // Present Comment Alert
        commentAddButton.rx.tap
            .bind(to: viewModel.shouldPresentCommentAlert)
            .disposed(by: disposeBag)
        
        viewModel.presentCommentAlert
            .drive(onNext: {
                let alert = UIAlertController(title: "댓글", message: nil, preferredStyle: .alert)
                alert.addTextField { textfield in
                    textfield.placeholder = "댓글을 입력하세요"
                }
                
                let cancelAction = UIAlertAction(title: "취소", style: .cancel)
                let doneAction = UIAlertAction(title: "완료", style: .default) { _ in
                    guard let content = alert.textFields?.first?.text else { return }
                    viewModel.shouldSaveComment.accept(FriendsMatchCommentRequestEntity(content: content))
                }
                
                [
                    cancelAction,
                    doneAction
                ]
                    .forEach { alert.addAction($0) }
                
                self.present(alert, animated: true)
            })
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
        
        [
            scrollView,
            commentAddButton
        ]
            .forEach { view.addSubview($0) }
        
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
        
        commentAddButton.snp.makeConstraints { make in
            make.height.width.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(verticalInset)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(horizontalInset + 5)
        }
        
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

//MARK: - Tab Gesture
extension FriendsMatchDetailViewController {
    func configureGesture() {
        
        let nicknameGesture = UITapGestureRecognizer(target: self, action: #selector(didTabNickname))
        detailInfoView.nicknameLabel.isUserInteractionEnabled = true
        detailInfoView.nicknameLabel.addGestureRecognizer(nicknameGesture)
    }
    
    @objc func didTabNickname(){
        viewModel?.didTabNickname.accept(Void())
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
