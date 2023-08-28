//
//  ProfileContentView.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/28.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class ProfileContentView: UIView {
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    var profileData: ProfileResponseEntity?
    
    //MARK: - View
    lazy var defaultView = ProfileDefaultView()
    
    //MARK: - Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(){
        super.init(frame: .zero)
        configureView()
        layout()
    }
    
    //MARK: - Function
    func bind(_ viewModel: ProfileContentViewModel) {
        
    }
}

//MARK: - Configure
private extension ProfileContentView {
    func configureView() {
        addSubview(defaultView)
    }
    
    func layout() {
        
        defaultView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
