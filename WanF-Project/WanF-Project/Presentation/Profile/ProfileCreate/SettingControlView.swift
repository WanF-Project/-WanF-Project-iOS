//
//  SettingControlView.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/03.
//

import UIKit

enum SettingControlType {
    case text
    case number
    case button
}

class SettingControlView: UIControl {
    
    //MARK: - Properties
    var title: String
    var placeholder: String
    var type: SettingControlType
    var handler: (() -> Void) = { }
    
    //MARK: - View
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .wanfFont(ofSize: 15, weight: .bold)
        label.textColor = .wanfLabel
        label.text = self.title
        
        return label
    }()
    
    lazy var contentTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = self.placeholder
        textField.borderStyle = .roundedRect
        textField.textColor = .wanfLabel
        textField.tintColor = .wanfMint
        textField.font = .wanfFont(ofSize: 15, weight: .regular)
        textField.isEnabled = false
        
        return textField
    }()
    
    //MARK: - Initialize
    override init(frame: CGRect) {
        self.title = ""
        self.placeholder = ""
        self.type = .text
        
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(title: String, placeholder: String, type: SettingControlType) {
        
        self.title = title
        self.placeholder = placeholder
        self.type = type
        
        super.init(frame: .zero)
        
        configure()
        layout()
    }
    
    //MARK: - Function
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch type {
        case .text:
            contentTextField.isEnabled = true
            contentTextField.becomeFirstResponder()
        case.number:
            contentTextField.isEnabled = true
            contentTextField.keyboardType = .numberPad
            contentTextField.becomeFirstResponder()
        case .button:
            contentTextField.isEnabled = false
            self.sendAction(#selector(didTapButton), to: self, for: .none)
        }
    }
    
    @objc func didTapButton() {
        handler()
    }
}

//MARK: - Configure
private extension SettingControlView {
    
    func configure() {
        
        [
            titleLabel,
            contentTextField
        ]
            .forEach { addSubview($0) }
        
    }
    
    func layout() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        contentTextField.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.top.bottom.equalTo(titleLabel)
            make.leading.equalTo(titleLabel.snp.trailing).offset(15)
            make.trailing.equalToSuperview()
        }
    }
}


