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
    
    lazy var bottomView: UIView = {
        var view = UIView()
        
        return view
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        configureView()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UI Configure
private extension SignInViewController {
    
    func configureView() {
        view.backgroundColor = .wanfMint
        
    }
    
    func layout() {
        
    }
}
