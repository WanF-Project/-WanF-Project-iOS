//
//  ProfilePreviewViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/06/04.
//

import Foundation

import RxSwift
import RxCocoa

struct ProfilePreviewViewModel {
    
    // Properties
    let disposeBag = DisposeBag()
    
    // Subcomponent ViewModel
    let profileContentViewModel = ProfileContentViewModel()
    
    // View -> ViewModel
    let shouldLoadProfilePreview = PublishRelay<Int>()
    let shouldPresentActivity = PublishRelay<Void>()
    
    // ViewModel -> View
    let presentActivity: Driver<String>
    
    init() {
        
        // Load ProfilePreview
        shouldLoadProfilePreview
            .withLatestFrom(Observable.just(profileContentViewModel)) { ($0, $1)}
            .subscribe(onNext: { id, viewModel in
                viewModel.loadProfilePreview.accept(id)
            })
            .disposed(by: disposeBag)
        
        // Present ActivityView for Contact
        presentActivity = shouldPresentActivity
            .withLatestFrom(profileContentViewModel.profileData, resultSelector: { _, profile in
                return profile.contact ?? ""
            })
            .asDriver(onErrorDriveWith: .empty())
    }
}
