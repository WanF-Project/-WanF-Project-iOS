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
        
        //데이터 연결
//        viewModel.profileData
//            .drive(onNext: { content in
//                self.profileData = content
//
//                self.profileImageView.image = content.profileImage != nil ? UIImage(named: content.profileImage!) : UIImage(systemName: "person")
//                self.profileNicknameLabel.text = content.nickname ?? "별명을 입력하세요"
//                self.profileMajorLabel.text = content.major?.name ?? "전공을 입력하세요"
//                self.profileEntranceYearLabel.text = (content.entranceYear ?? 0).description + "학번"
//                self.profileBirthLabel.text = (content.birth ?? 0).description + "살"
//                self.profileMBTILabel.text = content.mbti ?? "MBTI"
//                self.contactInfo = content.contact
//
//                var gender = "성별"
//                if content.gender != nil {
//                    gender = content.gender!.values.first!
//                }
//                self.profileGenderLabel.text = gender
//            })
//            .disposed(by: disposeBag)
        
        // 키워드 목록 구성
//        bindList(viewModel)
    }
    
//    func bindList(_ viewModel: ProfileContentViewModel) {
//
//        viewModel.personalityCellData
//            .drive(profilePersonalityListView.rx.items(cellIdentifier: "ProfileContentKeywordListCell", cellType: ProfileContentKeywordListCell.self)) { index, data, cell in
//                cell.configureCell(data)
//                cell.frame.size = cell.getContentSize()
//                cell.layoutIfNeeded()
//            }
//            .disposed(by: disposeBag)
//
//        viewModel.purposeCellData
//            .drive(profilePurposeListView.rx.items(cellIdentifier: "ProfileContentKeywordListCell", cellType: ProfileContentKeywordListCell.self)) {index, data, cell in
//                cell.configureCell(data)
//                cell.frame.size = cell.getContentSize()
//                cell.layoutIfNeeded()
//            }
//            .disposed(by: disposeBag)
//    }
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
