//
//  ProfileMainViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/11.
//

import Foundation

import RxSwift
import RxCocoa

struct ProfileMainViewModel {
    
    let disposeBag = DisposeBag()
    
    // Subcomponent ViewModel
    let profileContentViewModel = ProfileContentViewModel()
    
    // View <- ViewModel
    let didTapEditBarItem = PublishRelay<Void>()
    
    // ViewModel -> View
    let pushToProfileEdit: Driver<ProfileEditViewModel>
    
    init() {
        pushToProfileEdit = didTapEditBarItem
            .map {
                ProfileEditViewModel()
            }
            .asDriver(onErrorDriveWith: .empty())
    }
}
