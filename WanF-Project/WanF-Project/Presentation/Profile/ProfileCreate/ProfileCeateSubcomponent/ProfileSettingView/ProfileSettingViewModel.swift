//
//  ProfileSettingViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/04.
//

import Foundation

import RxSwift
import RxCocoa

class ProfileSettingViewModel {
    
    // Subcomponent ViewModel
    let profileKeywordSettingViewModel = ProfileKeywordSettingViewModel()
    let settingControlViewModel = SettingControlViewModel()
    
    // ViewModel -> Parent ViewModel
    let shouldMakeDoneButtonActive: Signal<ProfileRequestEntity>
    
    // View -> ViewModel
    let nameData = PublishRelay<String?>()
    let majorData = PublishRelay<String?>()
    let studentIDData = PublishRelay<String?>()
    let ageData = PublishRelay<String?>()
    let genderData = PublishRelay<String?>()
    let mbtiData = PublishRelay<String?>()
    let personalityData = PublishRelay<[String]>()
    let goalData = PublishRelay<[String]>()
    
    init() {
        
        let name = nameData
            .compactMap { $0 }
            .filter { !$0.isEmpty }
        
        let major = majorData
            .compactMap { $0 }
            .filter { !$0.isEmpty }

        let studentID = studentIDData
            .compactMap { $0 }
            .filter { !$0.isEmpty }

        let age = ageData
            .compactMap { $0 }
            .filter { !$0.isEmpty }

        let gender = genderData
            .compactMap { $0 }
            .filter { !$0.isEmpty }

        let mbti = mbtiData
            .compactMap { $0 }
            .filter { !$0.isEmpty }
        
        // 완료 버튼 활성화
        shouldMakeDoneButtonActive = Observable
            .combineLatest(name, major, studentID, age, gender, mbti, personalityData, goalData) {
                return ProfileRequestEntity(profileImage: "BEAR", nickname: $0, majorId: Int($1)!, entranceYear: Int($2)!, birth: Int($3)!, gender: $4, mbti: $5, personality: $6, purpose: $7, contact: "")
            }
            .asSignal(onErrorSignalWith: .empty())
    }
}
