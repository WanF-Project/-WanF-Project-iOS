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
    let makeDoneButtonActive: Signal<DoneButtonActiveData>
    let presentPhotoPicker: Driver<Void>
    let popToSignIn: Driver<Void>
    
    // View -> ViewModel
    let doneButtonTapped = PublishRelay<Void>()
    
    init(_ model: ProfileCreateModel = ProfileCreateModel()) {
        
        // 모든 정보가 입력되었다는 ShouldMakeDoneButtonActive가 오면 doneButton UI 변경하기(Driver나 Signal)
        makeDoneButtonActive = profileSettingViewModel.shouldMakeDoneButtonActive
        
        // Tap DoneButton
        let uploadResult = doneButtonTapped
            .withLatestFrom(makeDoneButtonActive)
            .compactMap {
                $0.imageInfo
            }
            .flatMap(model.uploadImage)
            .share()
        
        let uploadValue = uploadResult
            .compactMap(model.uploadImageValue)
        
        // TODO: - 프로필 생성 서버 연결 시 수정
        popToSignIn = uploadValue
            .map {_ in Void() }
            .asDriver(onErrorDriveWith: .empty())
        
        // Present Photo Picker
        presentPhotoPicker = profileSettingViewModel.shouldPresentPhotoPicker
    }
}
