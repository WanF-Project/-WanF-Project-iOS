//
//  ProfileSettingViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/04.
//

import Foundation

import RxSwift
import RxCocoa

typealias DoneButtonActiveData = (imageInfo: ImageInfo?, profile: ProfileRequestEntity)

class ProfileSettingViewModel {
    
    // Propertise
    let disposeBag = DisposeBag()
    
    // Subcomponent ViewModel
    let settingPhotoButtonViewModel = ProfileSettingPhotoButtonViewModel()
    
    let nameControlViewModel = SettingControlViewModel()
    let majorControlViewModel = SettingControlViewModel()
    let studentIDControlViewModel = SettingControlViewModel()
    let ageControlViewModel = SettingControlViewModel()
    let genderControlViewModel = SettingControlViewModel()
    let mbtiControlViewModel = SettingControlViewModel()
    
    let personalitySettingViewModel = ProfileKeywordSettingViewModel()
    let goalSettingViewModel = ProfileKeywordSettingViewModel()
    
    // ViewModel -> Parent ViewModel
    let shouldMakeDoneButtonActive: Signal<DoneButtonActiveData>
    let shouldPresentPhotoPicker: Driver<Void>
    
    // View -> ViewModel
    let photoButtonTapped = PublishRelay<Void>()
    
    // ViewModel
    let personalities = PublishRelay<[String]>()
    let goals = PublishRelay<[String]>()
    
    init() {
        
        let imageInfo = settingPhotoButtonViewModel.imageData
            .compactMap { $0 }
        
        let name = nameControlViewModel.stringValue
            .filter { !$0.isEmpty }
        
        let majorID = majorControlViewModel.nameableValue
            .map { $0.id }

        let studentID = studentIDControlViewModel.stringValue
            .compactMap { $0 }
            .filter { !$0.isEmpty }
            .compactMap { Int($0) }

        let ageNumber = ageControlViewModel.stringValue
            .compactMap { $0 }
            .filter { !$0.isEmpty }
            .compactMap { Int($0) }

        let gender = genderControlViewModel.stringValue
            .map {
                if $0 == "여자" { return "FEMALE" }
                else { return "MALE" }
            }
        
        let mbti = mbtiControlViewModel.stringValue
        
        personalitySettingViewModel.keyOfItems
            .bind(to: personalities)
            .disposed(by: disposeBag)
        
        goalSettingViewModel.keyOfItems
            .bind(to: goals)
            .disposed(by: disposeBag)
        
        // 완료 버튼 활성화
        shouldMakeDoneButtonActive = Observable
            .combineLatest(name, majorID, studentID, ageNumber, gender, mbti, personalities, goals) {
                ProfileRequestEntity(nickname: $0, majorId: $1, studentId: $2, age: $3, gender: $4, mbti: $5, personalities: $6, goals: $7)
            }
            .withLatestFrom(imageInfo, resultSelector: {
                DoneButtonActiveData(imageInfo: $1, profile: $0)
            })
            .asSignal(onErrorSignalWith: .empty())
        
        // Present Photo Picker
        shouldPresentPhotoPicker = photoButtonTapped
            .asDriver(onErrorDriveWith: .empty())
    }
}
