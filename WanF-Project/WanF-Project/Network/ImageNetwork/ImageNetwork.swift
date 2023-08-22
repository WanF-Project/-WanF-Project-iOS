//
//  ImageNetwork.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/21.
//

import Foundation

import RxSwift

class ImageNetwork: WanfNetwork {
    
    let api = ImageAPI()
    
    init() {
        super.init()
    }
    
    /// 이미지 업로드
    func postUploadImage(image: ImageInfo, directory: Directoty) -> Single<Result<ImageResponseEntity, WanfError>> {
        guard let url = api.postUploadImage(directory: directory).url else {
            return .just(.failure(.invalidURL))
        }
        
        let request = UserDefaultsManager.accessTokenCheckedObservable
            .flatMap { accessToken in
                MultipartNetwork(file: image.data, type: image.type, fileName: image.name)
                    .requestMultipartFormData(url)
            }
        
        return request
            .flatMap{
                super.session.rx.data(request: $0)
            }
            .map { data in
                do {
                    let decoded = try JSONDecoder().decode(ImageResponseEntity.self, from: data)
                    return .success(decoded)
                }
                catch {
                    return .failure(.invalidJSON)
                }
            }
            .catch { error in
                return .just(.failure(.networkError))
            }
            .asSingle()
    }
}

