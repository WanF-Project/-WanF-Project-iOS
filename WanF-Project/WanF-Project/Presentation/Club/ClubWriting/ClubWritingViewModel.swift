//
//  ClubWritingViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/09/26.
//

import Foundation

import RxSwift
import RxCocoa

class ClubWritingViewModel {
    
    let disposeBag = DisposeBag()
    
    // Subcomponent VieWModel
    let contentTextViewModel = WritingTextViewModel()
    let photoSettingViewModel = ProfileSettingPhotoButtonViewModel()
    
    // View -> ViewModel
    let didTabDoneButton = PublishRelay<Void>()
    let didSetNoneImage = PublishRelay<ImageResponseEntity?>()
    let content = PublishRelay<String>()
    
    // ViewModel -> View
    let postData: Observable<ClubPostRequestEntity>
    let activeDoneButton = PublishRelay<Bool>()
    
    init() {
        
        // Activate DoneButton
        contentTextViewModel.shouldActiveDoneButton
            .bind(to: activeDoneButton)
            .disposed(by: disposeBag)
        
        // Configure Data
        let imageResponse = photoSettingViewModel.imageData
            .map { _ in ImageResponseEntity(imageId: 0, imageUrl: "") }
            .amb(didSetNoneImage)
        
        postData = Observable
            .combineLatest(imageResponse, content, resultSelector: { imageResponse, content in
                if let imageId = imageResponse?.imageId {
                    return ClubPostRequestEntity(content: content, imageId: imageId)
                }
                return ClubPostRequestEntity(content: content, imageId: nil)
            })
        
        // Create Post
        let createResult = didTabDoneButton
            .withLatestFrom(postData)
        
        createResult
            .subscribe(onNext: { data in
                print("Create Post \(data)")
            })
            .disposed(by: disposeBag)
    }
}
