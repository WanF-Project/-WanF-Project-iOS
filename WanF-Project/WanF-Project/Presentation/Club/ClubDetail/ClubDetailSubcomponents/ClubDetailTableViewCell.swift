//
//  ClubDetailTableViewCell.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/22.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class ClubDetailTableViewCell: UITableViewCell {
    
    //MARK: - Propertied
    var viewModel: ClubDetailTableViewCellViewModel?
    
    //MARK: - View
    private lazy var detailInfoControl = PostUserInfoControlView()
    private lazy var contentLabel: UILabel = {
        var label = UILabel()
        label.text = "내용"
        label.font = .wanfFont(ofSize: 15, weight: .regular)
        label.textColor = .wanfLabel
        label.numberOfLines = 0
        
        return label
    }()
    private lazy var contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //MARK: - function
    func bind(_ viewModel: ClubDetailTableViewCellViewModel) {
        self.viewModel = viewModel
        
        // Bind Subcomponent ViewModel
        detailInfoControl.bind(viewModel.detailInfoViewModel)
    }
    
    func configureCell(_ post: ClubPostResponseEntity) {
        viewModel?.detailInfoViewModel.detailInfo.accept((post.nickname, post.createdDate))
        self.contentLabel.text = post.content
        self.contentImageView.image = UIImage(named: "WanfIcon_240")
        
        if let urlString = post.image?.imageUrl {
            let url = URL(string: urlString)
            url?.image({ image in
                DispatchQueue.main.async {
                    self.contentImageView.image = image
                }
            })
        }
    }
}

//MARK: - Configure
private extension ClubDetailTableViewCell {
    func configure() {
        backgroundColor = .wanfBackground
        
        [
            detailInfoControl,
            contentLabel,
            contentImageView
        ]
            .forEach { contentView.addSubview($0) }
    }
    
    func layout() {
        let verticalInset: CGFloat = 15.0
        let horizontalInset: CGFloat = 15.0
        let offset: CGFloat = 15.0
        
        detailInfoControl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(verticalInset)
            make.horizontalEdges.equalToSuperview().inset(5.0)
            make.height.equalTo(50)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(detailInfoControl.snp.bottom).offset(offset).priority(.high)
            make.left.equalToSuperview().inset(horizontalInset)
            
            make.width.equalTo(self).inset(horizontalInset * 2)
        }
        
        contentImageView.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(offset)
            make.horizontalEdges.equalToSuperview().inset(horizontalInset)
            make.bottom.equalToSuperview().inset(verticalInset)
            
            make.width.equalTo(self).inset(horizontalInset * 2).priority(.high)
            make.height.equalTo(contentImageView.snp.width)
        }
        
    }
}

