//
//  ClubListTableViewCell.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/15.
//

import UIKit

class ClubListTableViewCell: UITableViewCell {
    
    //MARK: - View
    private lazy var containerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .wanfBackground
        view.layer.shadowColor = UIColor.wanfGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 1
        
        return view
    }()
    
    private lazy var titleLable: UILabel = {
        let label = UILabel()
        
        label.text = "모임명"
        label.font = .wanfFont(ofSize: 15, weight: .bold)
        label.textColor = .wanfLabel
        
        return label
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .wanfMint
        
        return button
    }()
    
    //MARK: - LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configure()
        layout()
    }
    
    func configureCell(title: String) {
        self.titleLable.text = title
    }
}

//MARK: - Configure
private extension ClubListTableViewCell {
    func configure() {
        
        addSubview(containerView)
        
        [
            titleLable,
            shareButton
        ]
            .forEach { containerView.addSubview($0) }
    }
    
    func layout() {
        let titleWidth: CGFloat = self.frame.width / 2
        let verticalInset: CGFloat = 10.0
        let horizontalInset: CGFloat = 20.0
        
        containerView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(verticalInset)
            make.horizontalEdges.equalToSuperview().inset(horizontalInset)
        }
        
        titleLable.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(horizontalInset)
            make.width.equalTo(titleWidth)
        }
        
        shareButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLable)
            make.trailing.equalToSuperview().inset(horizontalInset)
        }
        
    }
}
