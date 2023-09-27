//
//  ClubWritingViewController.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/26.
//

import UIKit

import SnapKit

class ClubWritingViewController: UIViewController {
    
    //MARK: - View
    private let scrollView = UIScrollView()
    let doneButton = wanfDoneButton()
    let photoSettingButton = ProfileSettingPhotoButton()
    let contentTextView = WritingTextView(placeholder: "내용을 입력하세요", font: .wanfFont(ofSize: 18, weight: .regular))
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        layout()
        registerKeyboardNotifications()
    }
    
    func bind(_ viewModel: ClubWritingViewModel) {
        
        // Bind Subcomponent ViewModel
        contentTextView.bind(viewModel.contentTextView)
    }
}

//MARK: - Configure
private extension ClubWritingViewController {
    
    func configure() {
        view.backgroundColor = .wanfBackground
        [
            doneButton,
            scrollView
        ]
            .forEach { view.addSubview($0) }
        
        [
            photoSettingButton,
            contentTextView
        ]
            .forEach { scrollView.addSubview($0) }
        
    }
    
    func layout() {
        let horizontalInset: CGFloat = 15.0
        let verticalInset: CGFloat = 15.0
        let offset: CGFloat = 20.0
        
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(verticalInset)
            make.trailing.equalToSuperview().inset(horizontalInset)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(doneButton.snp.bottom).offset(offset)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(verticalInset)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        photoSettingButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(verticalInset)
            make.left.equalToSuperview().inset(horizontalInset)
            make.width.equalTo(150)
            make.height.equalTo(photoSettingButton.snp.width)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(photoSettingButton.snp.bottom).offset(offset)
            make.bottom.equalToSuperview().inset(verticalInset)
            make.horizontalEdges.equalToSuperview().inset(horizontalInset).priority(.high)
            make.width.equalTo(scrollView).inset(horizontalInset)
        }
    }
}

//MARK: - Adjust the view displaying the text
private extension ClubWritingViewController {
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
