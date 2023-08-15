//
//  AddBarButtonItem.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/15.
//

import UIKit

class AddBarButtonItem: UIBarButtonItem {
    
    override init() {
        super.init()
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.image = UIImage(systemName: "plus")
    }
}
