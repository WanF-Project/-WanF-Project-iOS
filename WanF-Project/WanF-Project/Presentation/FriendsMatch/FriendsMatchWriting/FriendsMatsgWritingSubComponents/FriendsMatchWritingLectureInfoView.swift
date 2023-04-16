//
//  FriendsMatchWritingLectureInfoView.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/14.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class FriendsMatchWritingLectureInfoView: UIView {
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    
    //MARK: -  View
    private lazy var lectureNameLabel: UILabel = {
        var label = UILabel()
        
        label.text = "강의명"
        label.textColor = .wanfLabel
        label.font = .wanfFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var professorNameLabel: UILabel = {
        var label = UILabel()
        
        label.text = "교수명"
        label.textColor = .wanfLabel
        label.font = .wanfFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 1
        
        return label
    }()
    
    //MARK: - LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureView()
        layout()
        
    }
    
    //MARK: - Function
    func bind(_ viewModel: FriendsMatchWritingLectureInfoViewModel) {
        viewModel.loadLectureInfo
            .drive(onNext: { lectureInfo in
                self.lectureNameLabel.text = lectureInfo.lectureName
                self.professorNameLabel.text = lectureInfo.professorName
            })
            .disposed(by: disposeBag)
    }
}

//MARK: - Configure
private extension FriendsMatchWritingLectureInfoView {
    func configureView() {
        
        backgroundColor = .wanfLightMint
        layer.shadowColor = UIColor.wanfLightGray.cgColor
        layer.shadowOpacity = 10.0
        layer.shadowOffset = CGSize(width: 0, height: 3.0)
        
        isUserInteractionEnabled = true
        
        [
            lectureNameLabel,
            professorNameLabel
        ]
            .forEach { self.addSubview($0) }
        
    }
    
    func layout() {
        
        let verticalInset = 20
        let horizontalInset = 35
        
        lectureNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(verticalInset)
            make.horizontalEdges.equalToSuperview().inset(horizontalInset)
        }
        
        professorNameLabel.snp.makeConstraints { make in
            make.top.equalTo(lectureNameLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(lectureNameLabel)
            make.bottom.equalToSuperview().inset(verticalInset)
        }
    }
}
