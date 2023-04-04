//
//  PasswordTextField.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/04.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

class PasswordTextField: UITextField {
    
    let disposeBag = DisposeBag()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureView()
    }
    
}

private extension PasswordTextField {
    
    func configureView() {
        keyboardType = .emailAddress
        placeholder = "비밀번호를 입력하세요"
        font = .wanfFont(ofSize: 13, weight: .regular)
        textColor = .label
        tintColor = .wanfMint
        backgroundColor = .wanfLightGray
        textAlignment = .center
        textContentType = .password
        isSecureTextEntry = true
        clearButtonMode = .whileEditing
    }
}
