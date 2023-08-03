//
//  WanfTopButton.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/03.
//

import UIKit

class wanfCancelButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "xmark")
        configuration.baseForegroundColor = .wanfMint

        self.configuration = configuration
    }
}

class wanfDoneButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "checkmark")
        configuration.baseForegroundColor = .wanfMint

        self.configuration = configuration
        self.isEnabled = false
    }
}
