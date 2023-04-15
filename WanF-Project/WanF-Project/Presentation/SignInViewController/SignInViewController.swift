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
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    
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
    
    let emailTextField = EmailTextField()
    
    let passwordTextField = PasswordTextField()
    
    private lazy var signInButton: UIButton = {
        var attributedTitle = AttributedString("로그인")
        attributedTitle.font = .wanfFont(ofSize: 13, weight: .extraBold)
        
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .wanfNavy
        configuration.baseForegroundColor = .wanfBackground
        configuration.attributedTitle = attributedTitle
        
        var button = UIButton(configuration: configuration)
        
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        var attributedTitle = AttributedString("회원가입")
        attributedTitle.font = .wanfFont(ofSize: 13, weight: .bold)
        
        var configuration = UIButton.Configuration.plain()
        configuration.baseForegroundColor = .wanfNavy
        configuration.attributedTitle = attributedTitle
        
        var button = UIButton(configuration: configuration)
        
        return button
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureView()
        layout()
    }
    
    //MARK: - Function
    func bind(_ viewModel: SignInViewModel) {
        
        // View -> ViewModel
        emailTextField.bind(viewModel.emailTextFieldViewModel)
        passwordTextField.bind(viewModel.passwordTextFieldViewModel)
        
        signInButton.rx.tap
            .bind(to: viewModel.signInButtonTapped)
            .disposed(by: disposeBag)
        
        signUpButton.rx.tap
            .bind(to: viewModel.signUpButtonTapped)
            .disposed(by: disposeBag)
        
        // ViewModel -> View
        viewModel.presentAlert
            .emit(to: self.rx.presentSignInErrorAlert)
            .disposed(by: disposeBag)
        
        viewModel.pushToMainTabBar
            .drive(onNext: { viewModel in
//                let mainTabBarVC = MainTabBarController()
//                mainTabBarVC.bind(viewModel)
//
//                SceneDelegate.shared.updateRootViewController(mainTabBarVC)
                let vc = LectureInfoViewController()
                vc.bind(LectureInfoViewModel())
                self.present(vc, animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.pushToSignUpID
            .drive(onNext: { viewModel in
                let signUpIDVC = SignUpIDViewController()
                signUpIDVC.bind(viewModel)
                
                self.navigationController?.pushViewController(signUpIDVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

//MARK: - UI Configure
private extension SignInViewController {
    func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = .wanfMint
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.wanfDarkGray ]
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

//MARK: - Reactive
extension Reactive where Base: SignInViewController {
    var presentSignInErrorAlert: Binder<Void> {
        return Binder(base) { base, _ in
            let alertViewContoller = UIAlertController(title: "로그인 오류", message: "이메일과 비밀번호를 확인해 주세요.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default)
            alertViewContoller.addAction(action)
            
            base.present(alertViewContoller, animated: true)
        }
    }
}
