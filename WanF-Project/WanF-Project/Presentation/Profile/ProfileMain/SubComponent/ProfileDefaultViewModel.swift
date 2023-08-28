//
//  ProfileDefaultViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/28.
//

import Foundation

import RxSwift
import RxCocoa

struct ProfileDefaultViewModel {
    
    let disposeBag = DisposeBag()
    
    // Subcomponent ViewModel
    let profileDetailViewModel = ProfileDetailViewModel()
    
    // Parent ViewModel ->ViewModel
    let shouldBindProfile = PublishRelay<ProfileResponseEntity>()
    
    // ViewModel -> View
    let image: Observable<ImageResponseEntity>
    let profile: Driver<ProfileResponseEntity>
    
    init() {
        image = shouldBindProfile
            .map { $0.image }
        
        profile = shouldBindProfile
            .asDriver(onErrorDriveWith: .empty())
        
        shouldBindProfile
            .bind(to: profileDetailViewModel.shouldBindProfile)
            .disposed(by: disposeBag)
    }
}
