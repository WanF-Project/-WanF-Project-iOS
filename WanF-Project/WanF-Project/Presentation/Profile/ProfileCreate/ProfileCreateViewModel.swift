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
    
    let makeDoneButtonActive: Signal<ProfileRequestEntity>
    
    init() {
        
        // 모든 정보가 입력되었다는 ShouldMakeDoneButtonActive가 오면 doneButton UI 변경하기(Driver나 Signal)
        makeDoneButtonActive = profileSettingViewModel.shouldMakeDoneButtonActive
    }
}
