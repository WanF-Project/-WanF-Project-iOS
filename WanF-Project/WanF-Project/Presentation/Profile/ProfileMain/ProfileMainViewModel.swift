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
        
        let profile = profileContentViewModel.profileData
        
        pushToProfileEdit = didTapEditBarItem
            .withLatestFrom(profile)
            .map { data in
                let viewModel = ProfileEditViewModel()
                viewModel.data.accept(data)
                return viewModel
            }
            .asDriver(onErrorDriveWith: .empty())
    }
}
