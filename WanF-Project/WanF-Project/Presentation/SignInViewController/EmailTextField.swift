//
//  EmailTextField.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/04.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

class EmailTextField: UITextField {
    
    let disposeBag = DisposeBag()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureView()
    }
    
    func bind(){
        
    }
}

private extension EmailTextField {
    
    func configureView() {
        placeholder = "학교 이메일을 입력하세요"
        font = .wanfFont(ofSize: 13, weight: .regular)
        textColor = .label
        tintColor = .wanfMint
        backgroundColor = .wanfLightGray
        textAlignment = .center
        textContentType = .emailAddress
        keyboardType = .emailAddress
        clearButtonMode = .whileEditing
    }
}
