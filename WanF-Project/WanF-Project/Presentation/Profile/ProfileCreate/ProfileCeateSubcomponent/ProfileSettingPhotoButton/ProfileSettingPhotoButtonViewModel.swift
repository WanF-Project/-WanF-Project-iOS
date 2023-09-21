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

class ProfileSettingPhotoButtonViewModel {
    
    let disposebag = DisposeBag()
    
    // Parent View -> ViewModel
    let shouldChangePreImageForCreate = PublishRelay<UIImage>()
    let shouldChangePreImageForEdit = PublishRelay<UIImage>()
    
    // ViewModel -> View
    let preImage: Driver<UIImage>
    
    // ViewModel -> Parent View
    let imageData: Observable<ImageInfo?>
    
    let changeSubject = PublishSubject<Observable<UIImage>>()
    let changeCreateSubject = PublishSubject<UIImage>()
    let changeEditSubject = PublishSubject<UIImage>()
    
    let dataSubject = PublishSubject<Observable<ImageInfo?>>()
    let dataCreateSubject = PublishSubject<ImageInfo?>()
    let dataEditSubject = PublishSubject<ImageInfo?>()
    
    
    init() {
        
        preImage = changeSubject
            .switchLatest()
            .asDriver(onErrorDriveWith: .empty())
        
        imageData = dataSubject
            .switchLatest()
     
        shouldChangePreImageForCreate
            .withUnretained(self)
            .subscribe(onNext: { (viewModel, image) in
                viewModel.changeSubject.onNext(viewModel.changeCreateSubject)
                viewModel.changeCreateSubject.onNext(image)
                
                guard let imageType = image.contentType,
                      let imageName = image.imageAsset?.value(forKey: "assetName") as? String
                else { return }
                let data: Data?
                switch imageType {
                case .jpeg:
                    data = image.jpegData(compressionQuality: 0.0)
                case .png:
                    data = image.pngData()
                }
                
                self.dataSubject.onNext(self.dataCreateSubject)
                self.dataCreateSubject.onNext((data ?? Data(), imageType, imageName))
            })
            .disposed(by: disposebag)
        
        shouldChangePreImageForEdit
            .withUnretained(self)
            .subscribe(onNext: { (viewModel, image) in
                viewModel.changeSubject.onNext(viewModel.changeEditSubject)
                viewModel.changeEditSubject.onNext(image)
                
                self.dataSubject.onNext(self.dataCreateSubject)
                self.dataCreateSubject.onNext(nil)
            })
            .disposed(by: disposebag)
    }
}
