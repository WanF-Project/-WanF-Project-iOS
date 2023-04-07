//
//  EmailStackViewCell.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/03.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class EmailStackViewCell: UITableViewCell {
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    
    //MARK: - View
    private lazy var emailStackView: UIStackView = {
        var stackView = UIStackView()
        
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        
        return stackView
    }()
    
    private lazy var idTextField: UITextField = {
        var textField = UITextField()
        
        textField.font = .wanfFont(ofSize: 16, weight: .regular)
        textField.placeholder = "아이디 입력"
        textField.textAlignment = .center
        textField.tintColor = .wanfMint
        textField.layer.borderColor = UIColor.wanfLightGray.cgColor
        textField.layer.borderWidth = 1.0
        
        return textField
    }()
    
    private lazy var emailAddressLabel: UILabel = {
        var label = UILabel()
        
        label.text = "@office.shku.ac.kr"
        label.font = .wanfFont(ofSize: 16, weight: .regular)
        label.textColor = .wanfDarkGray
        
        return label
    }()
    
    private lazy var verifiedButton: UIButton = {
        var button = UIButton()
        
        var attributedString = AttributedString("전송")
        attributedString.font = .wanfFont(ofSize: 13, weight: .bold)
        
        var configuration = UIButton.Configuration.filled()
        configuration.baseForegroundColor = .wanfBackground
        configuration.baseBackgroundColor = .wanfMint
        configuration.attributedTitle = attributedString
        
        button.configuration = configuration
        
        return button
    }()
    
    //MARK: - LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureView()
        layout()
    }
    
    //MARK: - Function
    func bind(_ viewModel: EmailStackViewCellViewModel) {
        
        // View -> ViewModel
        idTextField.rx.text
            .bind(to: viewModel.inputedIDText)
            .disposed(by: disposeBag)
        
        verifiedButton.rx.tap
            .bind(to: viewModel.sendEmailButtonTapped)
            .disposed(by: disposeBag)
        
    }
}

//MARK: - Configure
private extension EmailStackViewCell {
    
    func configureView() {
        
        [
            idTextField,
            emailAddressLabel,
            verifiedButton
        ]
            .forEach { emailStackView.addArrangedSubview($0) }
        
        [
            emailStackView
        ]
            .forEach { contentView.addSubview($0) }
    }
    
    func layout() {
        emailStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        idTextField.snp.makeConstraints { make in
            make.width.equalTo(130)
            make.height.equalTo(40)
        }
    }
}
