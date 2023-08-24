//
//  ProfileSingleSelectionListModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/06.
//

import Foundation

import RxSwift

struct ProfileSingleSelectionListModel<T: Nameable> {
    
    let majorNetwork = MajorNetwork()
    let profileNetwork = ProfileNetwork()
    
    // 전공 및 MBTI 목록 조회
    func getProfileSingleSelectionList() -> Single<Result<[T], WanfError>> {
        if T.self is MajorEntity.Type {
            return getMajorList() as! Single<Result<[T], WanfError>>
        } else {
            return getMBTIList() as! Single<Result<[T], WanfError>>
        }
    }
    
    func getProfileSingleSelectionListValue(_ result: Result<[T], WanfError>) -> [T]? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    func getProfileSingleSelectionListError(_ result: Result<[T], WanfError>) -> Void? {
        guard case .failure(let error) = result else {
            return nil
        }
        print("ERROR: \(error)")
        return Void()
    }
}

//MARK: - Function of Each Type
private extension ProfileSingleSelectionListModel {
    
    func getMajorList() -> Single<Result<[MajorEntity], WanfError>> {
        return majorNetwork.getAllMajors()
    }
    
    func getMBTIList() -> Single<Result<[MbtiEntity], WanfError>> {
        
        if let url = Bundle.main.url(forResource: "WanF", withExtension: "plist") {
            let dictionary = NSDictionary(contentsOf: url)
            let items = dictionary?["MBTI"] as? Array<String> ?? []
            var mbtiList: [MbtiEntity] = []
            
            for id in 0 ..< items.count {
                mbtiList.append(MbtiEntity(id: id, name: items[id]))
            }
            
            return .just(.success(mbtiList))
        }
        else {
            return .just(.failure(.networkError))
        }
    }
}

//MARK: - Type
enum ProfileSingleSelectionType {
    case major
    case MBTI
}
