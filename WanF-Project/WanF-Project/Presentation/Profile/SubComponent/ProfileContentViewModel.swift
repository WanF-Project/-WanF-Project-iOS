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
        
        let profileError = loadProfile
            .compactMap(model.getProfileError)
        
        // 데이터 연결
        profileData = profileValue
            .asDriver(onErrorDriveWith: .empty())
        
        personalityCellData = profileValue
            .map({ content in
                content.personality
            })
            .asDriver(onErrorDriveWith: .empty())
        
        purposeCellData = profileValue
            .map({ content in
                content.purpose
            })
            .asDriver(onErrorDriveWith: .empty())
    }
}
