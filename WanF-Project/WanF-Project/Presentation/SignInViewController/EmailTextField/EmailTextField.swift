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
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    
    //MARK: - LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureView()
    }
    
    //MARK: - Function
    func bind(_ viewModel: EmailTextFieldViewModel){
        self.rx.text
            .bind(to: viewModel.emailData)
            .disposed(by: disposeBag)
    }
}

//MARK: - Configure
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
