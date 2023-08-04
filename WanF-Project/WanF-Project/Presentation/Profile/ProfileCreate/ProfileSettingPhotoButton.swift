//
//  ProfileSettingPhotoButton.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/03.
//

import UIKit

class ProfileSettingPhotoButton: UIControl {
    
    let symbolImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "photo.on.rectangle")
        imageView.tintColor = .wanfMint
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        
        configure()
        layout()
    }
}

//MARK: - Configure
private extension ProfileSettingPhotoButton {
    func configure() {
        backgroundColor = .wanfDarkGray.withAlphaComponent(0.5)
        self.addSubview(symbolImageView)
    }
    
    func layout() {
        symbolImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
