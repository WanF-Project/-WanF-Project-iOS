//
//  CourseNetwork.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/19.
//

import Foundation

import RxSwift

class CourseNetwork: WanfNetwork {
    
    let api = CourseAPI()
    let disposeBag = DisposeBag()
    
    init() {
        super.init()
    }
    
    // 모든 강의 조회
    func getAllCourse() -> Single<Result<[LectureInfoEntity], WanfError>> {
        
        guard let url = api.getAllCourses().url else {
            return .just(.failure(.invalidURL))
        }
        
        let request  = UserDefaultsManager
            .accessTokenCheckedObservable
            .map { accessToken in
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.setValue(accessToken, forHTTPHeaderField: "Authorization")
                return request
            }
        
        return request
            .flatMap { request in
                return super.session.rx.data(request: request)
            }
            .map { data in
                do {
                    let decodedData = try JSONDecoder().decode([LectureInfoEntity].self, from: data)
                    return .success(decodedData)
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

