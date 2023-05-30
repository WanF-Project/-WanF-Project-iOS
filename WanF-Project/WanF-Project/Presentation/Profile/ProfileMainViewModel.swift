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
    
    // View -> ViewModel
    let shouldPatchProfile = PublishRelay<ProfileContentWritingEntity>()
    
    init() {
        
        shouldPatchProfile
            .withLatestFrom(Observable.just(profileContentViewModel), resultSelector: { profile, viewModel in
                (profile, viewModel)
            })
            .subscribe(onNext: { profile, viewModel in
                viewModel.patchProfile.accept(profile)
            })
            .disposed(by: disposeBag)
    }
}
