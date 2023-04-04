//
//  PasswordTextFieldCell.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/04.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class PasswordTextFieldCell: UITableViewCell {
    
    //MARK: - View
    private lazy var passwordTextField: UITextField = {
        var textField = UITextField()
        
        textField.font = .wanfFont(ofSize: 16, weight: .regular)
        textField.placeholder = "영문 • 숫자 조합으로 8자리 이상 작성하세요"
        textField.textAlignment = .center
        textField.tintColor = .wanfMint
        textField.layer.borderColor = UIColor.wanfLightGray.cgColor
        textField.layer.borderWidth = 1.0
        
        return textField
    }()
    
    //MARK: - LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureView()
        layout()
    }
}

//MARK: - Configure
private extension PasswordTextFieldCell {
    
    func configureView() {
        contentView.addSubview(passwordTextField)
    }
    
    func layout() {
        passwordTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(40)
        }
    }
}
