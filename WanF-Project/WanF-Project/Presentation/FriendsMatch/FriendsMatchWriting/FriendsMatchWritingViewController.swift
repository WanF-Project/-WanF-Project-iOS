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
    var titleText: String = ""
    var contentText: String = ""
    
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
    }
    
    //MARK: - Function
    func bind(_ viewModel: FriendsMatchWritingViewModel){
        
    }
}

private extension FriendsMatchWritingViewController {
    func configureView() {
        view.backgroundColor = .wanfBackground
        
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
            if textView.text != "제목을 입력하세요" { self.titleText = textView.text }
            if contentTextView.text == "내용을 입력하세요" { return }
        default:
            if textView.text != "내용을 입력하세요" { self.contentText = textView.text }
            if titleTextView.text == "제목을 입력하세요" { return }
        }
        
        topBarView.doneButton.isEnabled = true
    }
}
