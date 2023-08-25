//
//  MultipartNetwork.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/22.
//

import Foundation

import RxSwift

class MultipartNetwork {
    
    private let boundary = UUID().uuidString
    private let file: Data
    private let type: ImageContentType
    private let fileName: String
    
    init(file: Data, type: ImageContentType, fileName: String) {
        self.file = file
        self.type = type
        self.fileName = fileName
    }
    
    
    /// mutipart/form-data 타입의 request를 구성하여 반환
    func requestMultipartFormData(_ url: URL) -> Observable<URLRequest> {
        let contentType = "multipart/form-data; boundary=\(boundary)"
        
        let request = UserDefaultsManager.accessTokenCheckedObservable
            .compactMap { $0 }
            .map { accessToken in
                var request = URLRequest(url: url)
                request.httpMethod = WanfHttpMethod.post.rawValue
                request.setValue(accessToken, forHTTPHeaderField: "Authorization")
                request.setValue(contentType, forHTTPHeaderField: "Content-Type")
                request.httpBody = self.getMultipartHttpBody()
                
                return request
            }
        
        return request
    }
    
    private func getMultipartHttpBody() -> Data {
        let data = NSMutableData()
        
        data.append(convertFileToData())
        data.appendString("--\(boundary)--")
        
        return data as Data
    }
    
    private func convertFileToData() -> Data {
        let data = NSMutableData()
        let formField = "uploadImage"
        
        data.appendString("--\(boundary)\r\n")
        data.appendString("Content-Disposition: form-data; name=\"\(formField)\"; filename=\"\(fileName)\"\r\n")
        data.appendString("Content-Type: \(type.rawValue)\r\n")
        data.appendString("\r\n")
        data.append(file)
        data.appendString("\r\n")
        
        return data as Data
    }
}

