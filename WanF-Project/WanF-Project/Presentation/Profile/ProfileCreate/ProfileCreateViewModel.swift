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
    let shouldMakeDoneButtonActiveWithoutImage = PublishRelay<ImageInfo>()
    
    init(_ model: ProfileCreateModel = ProfileCreateModel()) {
        
        makeDoneButtonActive = profileSettingViewModel.shouldMakeDoneButtonActive
        
        let imageInfo = profileSettingViewModel.shouldMakeDoneButtonActive
            .compactMap { $0.imageInfo }
            .asObservable()
        
        let profile = profileSettingViewModel.shouldMakeDoneButtonActive
            .map { $0.profile }
        
        // Tap DoneButton
        let uploadResult = doneButtonTapped
            .withLatestFrom(imageInfo)
            .flatMap(model.uploadImage)
        
        let uploadValue = uploadResult
            .compactMap(model.uploadImageValue)
        
        let uploadError = uploadResult
            .compactMap(model.uploadImageError)
        
        let createResult = uploadValue
            .withLatestFrom(profile) {
                ProfileImageRequestEntity(imageId: $0.imageId, profileRequest: $1)
            }
            .flatMap(model.createProfile)
            
        let createValue = createResult
            .compactMap(model.createProfileValue)
        
        let createError = createResult
            .compactMap(model.createProfileError)
        
        popToSignIn = createValue
            .map {_ in Void() }
            .asDriver(onErrorDriveWith: .empty())
        
        // Present Photo Picker
        presentPhotoPicker = profileSettingViewModel.shouldPresentPhotoPicker
    }
}
