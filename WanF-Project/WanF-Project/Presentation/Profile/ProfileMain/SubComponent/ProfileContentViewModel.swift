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
    
    // Subcomponent ViewModel
    let profileDefaultViewModel = ProfileDefaultViewModel()
    
    // Parent ViewModel -> ViwModel
    let loadProfile = PublishRelay<Void>()
    
    // ViewModel -> Chile ViewModel
    let profileData: Observable<ProfileResponseEntity>
    
    // View -> ViewModel
    let loadProfilePreview = PublishRelay<Int>()
    
    // ViewModel -> View
    
    init(_ model: ProfileContentModel = ProfileContentModel()) {
        
        // 프로필 불러오기
        let loadProfileResult = loadProfile
            .flatMap(model.loadProfile)
            .share()
        
        let profileValue = loadProfileResult
            .compactMap(model.getProfileValue)
        
        let profileError = loadProfileResult
            .compactMap(model.getProfileError)
        
        // 특정 프로필 조회
        let loadProfilePreviewResult = loadProfilePreview
            .flatMap(model.loadProfilePreview)
            .share()
        
        let profilePreviewValue = loadProfilePreviewResult
            .compactMap(model.getProfilePreviewValue)
        
        let profilePreviewError = loadProfilePreviewResult
            .compactMap(model.getProfilePreviewError)
        
        // 데이터 연결
        profileData = profileValue
            .amb(profilePreviewValue)
        
        profileData
            .bind(to: profileDefaultViewModel.shouldBindProfile)
            .disposed(by: disposeBag)
    }
}
