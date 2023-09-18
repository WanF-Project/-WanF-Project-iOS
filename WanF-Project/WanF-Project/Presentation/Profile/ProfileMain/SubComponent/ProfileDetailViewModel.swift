//
//  ProfileDetailViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/28.
//

import Foundation

import RxSwift
import RxCocoa

struct ProfileDetailViewModel {
    
    // Parent ViewModel ->ViewModel
    let shouldBindProfile = PublishRelay<ProfileResponseEntity>()
    
    // ViewModel -> Parent ViewModel
    let shouldPushToMessageDetail: Signal<Int>
    
    // ViewModel -> View
    let profile: Driver<ProfileResponseEntity>
    let personalityCellData: Driver<[String]>
    let purposeCellData: Driver<[String]>
    let isEnableForMessageButton: Driver<Bool>
    
    // View -> ViewModel
    let didTapMessageButton = PublishRelay<Void>()
    
    init() {
        let value = shouldBindProfile
            .share()
        
        profile = value
            .asDriver(onErrorDriveWith: .empty())
        
        personalityCellData = value
            .map({ content in
                guard let personality = (content.personalities as NSDictionary).allValues as? Array<String> else
                { return [] }
                return personality
            })
            .asDriver(onErrorDriveWith: .empty())
        
        purposeCellData = value
            .map({ content in
                guard let purpose = (content.goals as NSDictionary).allValues as? Array<String> else
                { return [] }
                return purpose
            })
            .asDriver(onErrorDriveWith: .empty())
        
        shouldPushToMessageDetail = didTapMessageButton
            .withLatestFrom(profile, resultSelector: { _, profile in
                profile.id
            })
            .asSignal(onErrorSignalWith: .empty())
        
        let myID = Observable.just(UserDefaultsManager.profileID)
            .compactMap { $0 }
        
        isEnableForMessageButton = value
            .withLatestFrom(myID) { profile, id in
                if Int(id)! == profile.id {
                    return false
                }
                return true
            }
            .asDriver(onErrorDriveWith: .empty())
    }
}
