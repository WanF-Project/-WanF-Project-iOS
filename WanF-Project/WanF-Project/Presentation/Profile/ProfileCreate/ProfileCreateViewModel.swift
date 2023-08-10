//
//  ProfileCreateViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/04.
//

import Foundation

import RxSwift
import RxCocoa

class ProfileCreateViewModel {
    
    // Subcomponent ViewModel
    let profileSettingViewModel = ProfileSettingViewModel()
    
    // ViewModel -> View
    let makeDoneButtonActive: Signal<ProfileRequestEntity>
    let presentPhotoPicker: Driver<Void>
    
    // View -> ViewModel
    let doneButtonTapped = PublishRelay<Void>()
    
    init() {
        
        // 모든 정보가 입력되었다는 ShouldMakeDoneButtonActive가 오면 doneButton UI 변경하기(Driver나 Signal)
        makeDoneButtonActive = profileSettingViewModel.shouldMakeDoneButtonActive
        
        // Tap DoneButton
        let createResult = doneButtonTapped
            .withLatestFrom(makeDoneButtonActive)
        
        createResult
            .subscribe(onNext: {_ in
                print("Did Tap DoneButton")
            })
        
        // Present Photo Picker
        presentPhotoPicker = profileSettingViewModel.shouldPresentPhotoPicker
    }
}
