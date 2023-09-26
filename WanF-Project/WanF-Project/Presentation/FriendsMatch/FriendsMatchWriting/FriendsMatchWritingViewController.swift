//
//  FriendsMatchWritingViewController.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/11.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class FriendsMatchWritingViewController: UIViewController {
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    var viewModel: FriendsMatchWritingViewModel?
    
    //MARK: - View
    let topBarView = FriendsMatchWritingTopBarView()
    let lectureInfoView = FriendsMatchWritingLectureInfoView()
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    lazy var containerView: UIView = {
        var view = UIView()
        
        return view
    }()
    
    lazy var titleTextView = WritingTextView(placeholder: "제목을 입력하세요", font: .wanfFont(ofSize: 23, weight: .bold))
    
    lazy var contentTextView = WritingTextView(placeholder: "내용을 입력하세요", font: .wanfFont(ofSize: 18, weight: .regular))
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        layout()
        registerKeyboardNotifications()
    }
    
    //MARK: - Function
    func bind(_ viewModel: FriendsMatchWritingViewModel){
        self.viewModel = viewModel
        
        // Bind Subcomponent
        topBarView.bind(viewModel.topBarViewModel)
        lectureInfoView.bind(viewModel.friendsMatchWritingLectureInfoViewModel)
        titleTextView.bind(viewModel.titleViewModel)
        contentTextView.bind(viewModel.contentViewModel)
        
        // View -> ViewModel
        titleTextView.rx.text
            .bind(to: viewModel.titleText)
            .disposed(by: disposeBag)
        
        contentTextView.rx.text
            .bind(to: viewModel.contentText)
            .disposed(by: disposeBag)
        
        // ViewModel -> View
        viewModel.dismiss
            .drive(onNext: {
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.activateDoneButton
            .drive(onNext: { state in
                self.topBarView.doneButton.isEnabled = state
            })
            .disposed(by: disposeBag)
        
        viewModel.presentAlert
            .emit(to: self.rx.presentSaveErrorAlert)
            .disposed(by: disposeBag)
    }
}

private extension FriendsMatchWritingViewController {
    func configureView() {
        view.backgroundColor = .wanfBackground
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapLectureInfoView))
        lectureInfoView.addGestureRecognizer(tapGesture)
        
        [
            topBarView,
            lectureInfoView,
            scrollView
        ]
            .forEach { view.addSubview($0) }
        
        scrollView.addSubview(containerView)
        
        [
            titleTextView,
            contentTextView
        ]
            .forEach { containerView.addSubview($0) }
    }
    
    func layout() {
        
        let inset = 20
        let offset = 10
        
        topBarView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(inset)
        }
        
        lectureInfoView.snp.makeConstraints { make in
            make.top.equalTo(topBarView.snp.bottom).offset(offset)
            make.horizontalEdges.equalTo(topBarView)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(lectureInfoView.snp.bottom).offset(offset)
            make.horizontalEdges.equalTo(topBarView)
            make.bottom.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
        
        titleTextView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(inset)
            make.horizontalEdges.equalToSuperview()
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextView.snp.bottom).offset(offset)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

// TODO: - RxSwift로 Refactoring
//MARK: - Adjust the view displaying the text
private extension FriendsMatchWritingViewController {
    func registerKeyboardNotifications(){
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else { return }
        
        let contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardFrame.height, right: 0.0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        let contentInset = UIEdgeInsets.zero
        
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
}

//MARK: - Object-C
extension FriendsMatchWritingViewController {
    @objc func didTapLectureInfoView() {
        let lectureInfoVC = CourseInfoListViewController()
        let lectureInfoViewModel = CourseInfoListViewModel()
        lectureInfoVC.bind(lectureInfoViewModel)
        
        if self.viewModel != nil {
            lectureInfoViewModel.didSelectLectureInfo
                .emit(to: self.viewModel!.lectureInfo)
                .disposed(by: disposeBag)
        }
        
        self.present(lectureInfoVC, animated: true)
    }
}

//MARK: - Reactive
extension Reactive where Base: FriendsMatchWritingViewController {
    var presentSaveErrorAlert: Binder<Void> {
        return Binder(base) { base, _ in
            let alertViewContoller = UIAlertController(title: "저장 실패", message: "잠시 후 다시 시도해 주세요", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default)
            alertViewContoller.addAction(action)
            
            base.present(alertViewContoller, animated: true)
        }
    }
}
