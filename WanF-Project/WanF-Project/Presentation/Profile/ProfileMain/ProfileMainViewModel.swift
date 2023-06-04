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
    let shouldLoadProfile = PublishRelay<Void>()
    let shouldPatchProfile = PublishRelay<ProfileContentWritingEntity>()
    let shouldRefreshProfile = PublishRelay<Void>()
    
    init() {
        
        // 프로필 조회
        shouldLoadProfile
            .withLatestFrom(Observable.just(profileContentViewModel))
            .subscribe(onNext: { viewModel in
                viewModel.subject.onNext(viewModel.loadProfileSubject)
                viewModel.loadProfileSubject.onNext(Void())
            })
            .disposed(by: disposeBag)
        
        // 프로필 수정
        shouldPatchProfile
            .withLatestFrom(Observable.just(profileContentViewModel), resultSelector: { profile, viewModel in
                (profile, viewModel)
            })
            .subscribe(onNext: { profile, viewModel in
                viewModel.patchProfile.accept(profile)
            })
            .disposed(by: disposeBag)
        
        // 프로필 새로고침
        shouldRefreshProfile
            .withLatestFrom(Observable.just(profileContentViewModel))
            .subscribe(onNext: { viewModel in
                viewModel.subject.onNext(viewModel.refreshProfileSubject)
                viewModel.refreshProfileSubject.onNext(Void())
            })
            .disposed(by: disposeBag)
    }
}
