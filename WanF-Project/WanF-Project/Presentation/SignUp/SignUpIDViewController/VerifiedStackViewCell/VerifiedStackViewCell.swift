//
//  VerifiedStackViewCell.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/03.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class VerifiedStackViewCell: UITableViewCell {
    
    //MARK: - View
    private lazy var verifiedStackView: UIStackView = {
        var stackView = UIStackView()
        
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        
        return stackView
    }()
    
    private lazy var verificationCodeLabel: UILabel = {
        var label = UILabel()
        
        label.text = "인증번호"
        label.textAlignment = .center
        label.font = .wanfFont(ofSize: 16, weight: .regular)
        label.textColor = .wanfDarkGray
        
        return label
    }()
    
    private lazy var verificationCodeTextField: UITextField = {
        var textField = UITextField()
        
        textField.font = .wanfFont(ofSize: 16, weight: .regular)
        textField.placeholder = "인증번호 입력"
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
    
    //MARK: - Function
    func bind(_ viewModel: VerifiedStackViewCellViewModel) {
        
        // View -> ViewModel
        verificationCodeTextField.rx.text
            .bind(to: viewModel.inputedVerifiedCode)
            .disposed(by: DisposeBag())
        
        // ViewModel -> View
        
    }
}

//MARK: - Configure
private extension VerifiedStackViewCell {
    
    func configureView() {
        
        [
            verificationCodeLabel,
            verificationCodeTextField
        ]
            .forEach { verifiedStackView.addArrangedSubview($0) }
        
        [
            verifiedStackView
        ]
            .forEach { contentView.addSubview($0) }
    }
    
    func layout() {
        verifiedStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        verificationCodeTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }
}
