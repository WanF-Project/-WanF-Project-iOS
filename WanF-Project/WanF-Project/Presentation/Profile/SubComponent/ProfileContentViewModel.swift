//
//  ProfileContentViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/28.
//

import Foundation

import RxSwift
import RxCocoa

struct ProfileContentViewModel {
    
    let disposeBag = DisposeBag()
    
    // View -> ViewModel
    let patchProfile = PublishRelay<ProfileContentWritingEntity>()
    
    // ViewModel -> View
    let profileData: Driver<ProfileContent>
    let personalityCellData: Driver<[String]>
    let purposeCellData: Driver<[String]>
    
    init(_ model: ProfileContentModel = ProfileContentModel()) {
        
        // 프로필 불러오기
        let loadProfile = model.loadProfile()
            .asObservable()
            .share()
        
        let profileValue = loadProfile
            .compactMap(model.getProfileValue)
            .share()
        
        let profileError = loadProfile
            .compactMap(model.getProfileError)
        
        // 데이터 연결
        profileData = profileValue
            .asDriver(onErrorDriveWith: .empty())
        
        personalityCellData = profileValue
            .map({ content in
                guard let personality = (content.personality as NSDictionary).allValues as? Array<String> else
                { return [] }
                return personality
            })
            .asDriver(onErrorDriveWith: .empty())
        
        purposeCellData = profileValue
            .map({ content in
                guard let purpose = (content.purpose as NSDictionary).allValues as? Array<String> else
                { return [] }
                return purpose
            })
            .asDriver(onErrorDriveWith: .empty())
        
        // 프로필 수정
        let patchProfileResult = patchProfile
            .flatMap(model.patchProfile)
            .share()
        
        let patchProfileValue = patchProfileResult
            .compactMap(model.getPatchProfileValue)
        
        patchProfileValue.subscribe().disposed(by: disposeBag)
        
        let patchProfileError = patchProfileResult
            .compactMap(model.getPatchProfileError)
    }
}
