//
//  SignInViewController.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/01.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class SignInViewController: UIViewController {
    
    //MARK: - View
    private lazy var appIconImageView: UIImageView = {
        var imageView = UIImageView(image: UIImage(named: "AppIcon"))
        
        return imageView
    }()
    
    private lazy var bottomView: UIView = {
        var view = UIView()
        
        view.backgroundColor = .wanfBackground
        view.roundCorner(round: 20, [.topLeft, .topRight])
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0.0, height: -3.0)
        
        return view
    }()
    
    private lazy var emailTextField: UITextField = {
        var textField = UITextField()
        
        textField.placeholder = "학교 이메일을 입력하세요"
        textField.font = .wanfFont(ofSize: 13, weight: .regular)
        textField.textColor = .label
        textField.tintColor = .wanfMint
        textField.backgroundColor = .wanfLightGray
        textField.textAlignment = .center
        textField.textContentType = .emailAddress
        textField.keyboardType = .emailAddress
        textField.clearButtonMode = .whileEditing
        
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        var textField = UITextField()
        
        textField.keyboardType = .emailAddress
        textField.placeholder = "비밀번호를 입력하세요"
        textField.font = .wanfFont(ofSize: 13, weight: .regular)
        textField.textColor = .label
        textField.tintColor = .wanfMint
        textField.backgroundColor = .wanfLightGray
        textField.textAlignment = .center
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.clearButtonMode = .whileEditing
        
        return textField
    }()
    
    private lazy var signInButton: UIButton = {
        var attributedTitle = AttributedString("로그인")
        attributedTitle.font = .wanfFont(ofSize: 13, weight: .extraBold)
        
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .wanfNavy
        configuration.baseForegroundColor = .wanfBackground
        configuration.attributedTitle = attributedTitle
        
        let action = UIAction { _ in
            print("Sign In")
        }
        
        var button = UIButton(configuration: configuration, primaryAction: action)
        
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        var attributedTitle = AttributedString("회원가입")
        attributedTitle.font = .wanfFont(ofSize: 13, weight: .bold)
        
        var configuration = UIButton.Configuration.plain()
        configuration.baseForegroundColor = .wanfNavy
        configuration.attributedTitle = attributedTitle
        
        let action = UIAction { _ in
            print("Sign Up")
        }
        
        var button = UIButton(configuration: configuration, primaryAction: action)
        
        return button
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureView()
        layout()
    }
}

//MARK: - UI Configure
private extension SignInViewController {
    func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = .wanfMint
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.wanfDarkGray ]
        navigationItem.title = ""
    }
    
    func configureView() {
        view.backgroundColor = .wanfMint
        
        //view
        [
            appIconImageView,
            bottomView
        ]
            .forEach { view.addSubview($0) }
        
        //bottom view
        [
            emailTextField,
            passwordTextField,
            signInButton,
            signUpButton
        ]
            .forEach { bottomView.addSubview($0) }
        
    }
    
    func layout() {
        
        //view
        appIconImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(-40)
            make.height.equalTo(200)
            make.width.equalTo(appIconImageView.snp.height)
        }
        
        bottomView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(appIconImageView.snp.bottom)
        }
        
        //bottom view
        emailTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(60)
            make.width.equalTo(300)
            make.height.equalTo(40)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailTextField.snp.bottom).offset(15)
            make.height.width.equalTo(emailTextField)
        }
        
        signInButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.height.width.equalTo(emailTextField)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signInButton.snp.bottom).offset(15)
        }
        
    }
}
