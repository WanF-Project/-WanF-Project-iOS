//
//  PasswordToCheckTextFieldCell.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/04.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class  PasswordToCheckTextFieldCell: UITableViewCell {
    
    private lazy var passwordToCheckTextField: UITextField = {
        var textField = UITextField()
        
        textField.font = .wanfFont(ofSize: 16, weight: .regular)
        textField.placeholder = "비밀번호 확인"
        textField.textAlignment = .center
        textField.tintColor = .wanfMint
        textField.layer.borderColor = UIColor.wanfLightGray.cgColor
        textField.layer.borderWidth = 1.0
        
        return textField
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureView()
        layout()
    }
}

private extension  PasswordToCheckTextFieldCell {
    
    func configureView() {
        contentView.addSubview(passwordToCheckTextField)
    }
    
    func layout() {
        passwordToCheckTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(40)
        }
    }
}

