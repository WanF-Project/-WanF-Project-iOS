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
    
    // Subcomponent ViewModel
    let profileContentViewModel = ProfileContentViewModel()
    
    // View -> ViewModel
    
    // ViewModel -> View
    let pushToMessageDetail: Driver<MessageDetailViewModel>
    
    init() {
        pushToMessageDetail = profileContentViewModel.profileDefaultViewModel.profileDetailViewModel.shouldPushToMessageDetail
            .map { id in
                let messageDetailViewModel = MessageDetailViewModel()
                messageDetailViewModel.id.accept(id)
                return messageDetailViewModel
            }
            .asDriver(onErrorDriveWith: .empty())
    }
}
