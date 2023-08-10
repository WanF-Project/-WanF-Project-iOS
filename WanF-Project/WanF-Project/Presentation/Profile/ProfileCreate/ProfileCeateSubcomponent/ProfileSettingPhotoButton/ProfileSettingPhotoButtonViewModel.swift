//
//  ProfileSettingPhotoButtonViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/10.
//

import UIKit

import RxSwift
import RxCocoa

struct ProfileSettingPhotoButtonViewModel {
    
    // Parent View -> ViewModel
    let shouldChangePreImage = PublishRelay<UIImage>()
    
    // ViewModel -> View
    let preImage: Driver<UIImage>
    
    init() {
        preImage = shouldChangePreImage
            .asDriver(onErrorDriveWith: .empty())
    }
    
}
