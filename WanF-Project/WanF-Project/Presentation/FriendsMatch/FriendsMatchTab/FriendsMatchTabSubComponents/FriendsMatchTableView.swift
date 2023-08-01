//
//  FriendsMatchTableView.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/01.
//

import UIKit

class FriendsMatchTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero, style: .plain)
        
        configure()
    }
}

private extension FriendsMatchTableView {
    func configure() {
        
        self.backgroundColor = .wanfBackground
        self.separatorStyle = .none
        self.rowHeight = 120
        
        self.register(FriendsMatchListCell.self, forCellReuseIdentifier: "FriendsMatchListCell")
    }
}
