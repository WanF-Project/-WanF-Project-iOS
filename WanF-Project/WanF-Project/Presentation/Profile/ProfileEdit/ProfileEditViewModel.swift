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
    
    let imageID = PublishRelay<Int>()
    
    // View -> ViewModel
    let didTapDoneButton = PublishRelay<Void>()
    
    // ViewModel -> View
    let data = PublishRelay<ProfileResponseEntity>()
    let presentPickerView: Driver<Void>
    let dismiss: Driver<ProfileResponseEntity>
    
    
    init(_ model: ProfileEditModel = ProfileEditModel()) {
        data
            .bind(to: profileSettingViewModel.data)
            .disposed(by: disposeBag)
        
        presentPickerView = profileSettingViewModel.shouldPresentPhotoPicker
            .asDriver(onErrorDriveWith: .empty())
        
        // Upload Image
        let profile = didTapDoneButton
            .withLatestFrom(profileSettingViewModel.shouldMakeDoneButtonActive)
            .map { $0.profile }
            .asObservable()
        
        let imageInfo = didTapDoneButton
            .withLatestFrom(profileSettingViewModel.shouldMakeDoneButtonActive)
            .compactMap { $0.imageInfo }
        
        let imageResult = imageInfo
            .flatMap(model.uploadImage)
            .share()
        
        let imageValue = imageResult
            .compactMap(model.uploadImageValue)
            .map { $0.imageId }
        
        let imageError = imageResult
            .compactMap(model.uploadImageError)
        
        imageError
            .subscribe(onNext: {
                print("Error: \($0)")
            })
            .disposed(by: disposeBag)
        
        let existingImageId = didTapDoneButton
            .withLatestFrom(profileSettingViewModel.imageID)
            .withLatestFrom(profileSettingViewModel.shouldMakeDoneButtonActive) { id, data in
                if data.imageInfo == nil {
                    return id
                }
                return nil
            }
            .compactMap { $0 }
        
        let imageID = imageValue
            .amb(existingImageId)
        
        // Edit Profile
        let editData = profile
            .withLatestFrom(imageID) { profile, imageID in
                return ProfileImageRequestEntity(imageId: imageID, profileRequest: profile)
            }
        
        let editResult = editData
            .flatMap(model.editProfile)
            .share()
        
        let editValue = editResult
            .compactMap(model.editProfileValue)
        
        let editError = editResult
            .compactMap(model.editProfileError)
        
        editError
            .subscribe(onNext: {
                print("Error: \($0)")
            })
            .disposed(by: disposeBag)
        
        // Dismiss ProfileEdit
        dismiss = editValue
            .asDriver(onErrorDriveWith: .empty())
        
    }
}
