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
    
    lazy var titleTextView: UITextView = {
        var textView = UITextView()
        
        textView.isScrollEnabled = false
        textView.isEditable = true
        textView.text = "제목을 입력하세요"
        textView.font = .wanfFont(ofSize: 23, weight: .bold)
        textView.tintColor = .wanfMint
        textView.textColor = .placeholderText
        textView.delegate = self
        
        return textView
    }()
    
    lazy var contentTextView: UITextView = {
        var textView = UITextView()
        
        textView.isScrollEnabled = false
        textView.isEditable = true
        textView.text = "내용을 입력하세요"
        textView.font = .wanfFont(ofSize: 18, weight: .regular)
        textView.tintColor = .wanfMint
        textView.textColor = .placeholderText
        textView.delegate = self
        
        return textView
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        layout()
        registerKeyboardNotifications()
    }
    
    //MARK: - Function
    func bind(_ viewModel: FriendsMatchWritingViewModel){
        
        topBarView.bind(viewModel.topBarViewModel)
        
        // View -> ViewModel
        
        // ViewModel -> View
        viewModel.dismiss
            .drive(onNext: {
                self.dismiss(animated: true)
            })
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
//MARK: - TextViewDelegate
extension FriendsMatchWritingViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == UIColor.placeholderText else{ return }
        
        textView.text = ""
        textView.textColor = .wanfLabel
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = textView == self.titleTextView ? "제목을 입력하세요" : "내용을 입력하세요"
            textView.textColor = .placeholderText
            topBarView.doneButton.isEnabled = false
            
            return
        }
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            topBarView.doneButton.isEnabled = false
            return
        }
        
        switch textView {
        case titleTextView:
            if contentTextView.text == "내용을 입력하세요" { return }
        case contentTextView:
            if titleTextView.text == "제목을 입력하세요" { return }
        default:
            return
        }
        
        topBarView.doneButton.isEnabled = true
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
        let lectureInfoVC = LectureInfoViewController()
        lectureInfoVC.bind(LectureInfoViewModel())
        
        self.present(lectureInfoVC, animated: true)
    }
}
