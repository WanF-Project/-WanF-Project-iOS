//
//  ProfileKeywordView.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/04.
//

import UIKit

import RxSwift
import RxCocoa

class ProfileKeywordSettingView: UIControl {
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    let title: String
    var handler: () -> Void = {}
    
    //MARK: - View
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = self.title
        label.font = .wanfFont(ofSize: 15, weight: .bold)
        label.textColor = .wanfLabel
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var listView: DynamicHeightCollectionView = {
        
        let layout = LeadingAlignmentCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 8
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        
        collectionView.register(ProfileContentKeywordListCell.self, forCellWithReuseIdentifier: "ProfileContentKeywordListCell")
        
        return collectionView
    }()
    
    //MARK: - Initialize
    override init(frame: CGRect) {
        self.title = ""
        
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String) {
        self.title = title
        
        super.init(frame: .zero)
        
        configure()
        layout()
    }
    
    convenience init(title: String, handler: @escaping () -> Void) {
        self.init(title: title)
        self.handler = handler
    }
    
    //MARK: - Function
    func bind(_ viewModel: ProfileKeywordSettingViewModel) {
        viewModel.cellData
            .drive(listView.rx.items(cellIdentifier: "ProfileContentKeywordListCell", cellType: ProfileContentKeywordListCell.self)) { index, data, cell in
                cell.configureCell(data)
                cell.frame.size = cell.getContentSize()
                cell.layoutIfNeeded()
            }
            .disposed(by: disposeBag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        handler()
    }
}

//MARK: - Configure
private extension ProfileKeywordSettingView {
    func configure() {
        
        [
            titleLabel,
            listView
        ]
            .forEach { self.addSubview($0) }
    }
    
    func layout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        listView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(titleLabel)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
