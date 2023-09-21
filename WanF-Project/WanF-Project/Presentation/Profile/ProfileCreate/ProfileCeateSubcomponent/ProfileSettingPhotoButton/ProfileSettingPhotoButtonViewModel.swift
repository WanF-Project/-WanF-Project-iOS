//
//  ProfileSettingPhotoButtonViewModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/10.
//

import UIKit

import RxSwift
import RxCocoa

typealias ImageInfo = (data: Data, type: ImageContentType, name: String)

struct ProfileSettingPhotoButtonViewModel {
    
    // Parent View -> ViewModel
    let shouldChangePreImageForCreate = PublishRelay<UIImage>()
    let shouldChangePreImageForEdit = PublishRelay<UIImage>()
    
    // ViewModel -> View
    let preImage: Driver<UIImage>
    
    // ViewModel -> Parent View
    let imageData: Observable<ImageInfo?>
    
    init() {
        preImage = shouldChangePreImageForCreate
            .amb(shouldChangePreImageForEdit)
            .asDriver(onErrorDriveWith: .empty())
        
        let forCreate: Observable<ImageInfo?> = shouldChangePreImageForCreate
            .map {
                guard let imageType = $0.contentType,
                      let imageName = $0.imageAsset?.value(forKey: "assetName") as? String
                else { return nil }
                
                let data: Data?
                switch imageType {
                case .jpeg:
                    data = $0.jpegData(compressionQuality: 0.0)
                case .png:
                    data = $0.pngData()
                }
                return (data ?? Data(), imageType, imageName)
            }
        
        let forEdit: Observable<ImageInfo?> = shouldChangePreImageForEdit
            .map { _ in
                return nil
            }
        
        imageData = forCreate
            .amb(forEdit)
    }
    
}
