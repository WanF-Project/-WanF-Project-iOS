//
//  ProfileEditViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/19.
//

import Foundation

import RxSwift
import RxCocoa

class ProfileEditViewModel {
    
    let disposeBag = DisposeBag()
    
    // Subcomponent ViewModel
    let profileSettingViewModel = ProfileSettingViewModel()
    
    // ViewModel ->View
    let data = PublishRelay<ProfileResponseEntity>()
    let presentPickerView: Driver<Void>
    
    init() {
        data
            .bind(to: profileSettingViewModel.data)
            .disposed(by: disposeBag)
        
        presentPickerView = profileSettingViewModel.shouldPresentPhotoPicker
            .asDriver(onErrorDriveWith: .empty())
    }
}
