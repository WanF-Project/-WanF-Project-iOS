//
//  CSKeyboardToolBar.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/05.
//

import UIKit

class CSKeyboardToolBar: UIToolbar {
    
    //MARK: - Properties
    var handler: () -> Void = {}
    
    //MARK: - View
    lazy var doneButton: UIBarButtonItem = {
        let barItem = UIBarButtonItem()
        
        barItem.title = "완료"
        barItem.tintColor = .wanfMint
        barItem.action = #selector(didTapDoneButton)
        
        return barItem
    }()
    
    //MARK: - Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(handler: @escaping () -> Void) {
        self.handler = handler
        
        super.init(frame: .zero)
        
        configure()
    }
    
    //MARK: - Function
    @objc func didTapDoneButton() {
        handler()
    }
}


private extension CSKeyboardToolBar {
    func configure() {
        
        self.sizeToFit()
        self.backgroundColor = .wanfLightGray
        self.setItems([doneButton], animated: true)
    }
}
