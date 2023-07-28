//
//  CSSearchBarView.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/07/28.
//

import UIKit

import RxSwift
import RxCocoa

class CSSearchBar: UISearchBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        
        configureView()
    }
}

//MARK: - Configure
private extension CSSearchBarView {
    func configureView() {
        self.searchBarStyle = .minimal
    }
}
