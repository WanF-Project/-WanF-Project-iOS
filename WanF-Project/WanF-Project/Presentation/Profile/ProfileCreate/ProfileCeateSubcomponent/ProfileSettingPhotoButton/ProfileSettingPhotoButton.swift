//
//  ProfileSettingPhotoButton.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/03.
//

import UIKit

import RxSwift
import RxCocoa

class ProfileSettingPhotoButton: UIControl {
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    
    //MARK: - View
    let preImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .wanfMint
        return imageView
    }()
    
    let backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .wanfDarkGray.withAlphaComponent(0.5)
        return imageView
    }()
    
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
    
    //MARK: - Function
    func bind(_ viewModel: ProfileSettingPhotoButtonViewModel) {
        viewModel.preImage
            .drive(onNext: {
                self.preImageView.image = $0
            })
            .disposed(by: disposeBag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.sendActions(for: .touchUpInside)
    }
}

//MARK: - Configure
private extension ProfileSettingPhotoButton {
    func configure() {
        
        [
            preImageView,
            backgroundView,
            symbolImageView
        ]
            .forEach { self.addSubview($0) }
    }
    
    func layout() {
        
        preImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        symbolImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
