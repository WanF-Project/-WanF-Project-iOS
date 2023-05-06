//
//  ProfileSingleSelectionListModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/06.
//

import Foundation

import RxSwift

// TODO: - 서버 연결 시 재구현
struct ProfileSingleSelectionListModel {
    
    func getProfileSingleSelectionList(_ type: ProfileSingleSelectionType) -> Observable<[String]> {
        switch type {
        case .major:
            return getMajorList()
        case .MBTI:
            return getMBTIList()
        }
    }
    
    func saveProfileSingleSelectionList (_ data: String, type: ProfileSingleSelectionType) -> Observable<Bool> {
        switch type {
        case .major:
            return saveMajor(data)
        case .MBTI:
            return saveMBTI(data)
        }
    }
    
    func getSavedProfileSingleSelectionListValue(_ result: Bool) -> Bool? {
        if !result {
            return nil
        }
        return true
    }
    
    func getSavedProfileSingleSelectionListError(_ result: Bool) -> Bool? {
        if result {
            return nil
        }
        return false
    }
}

//MARK: - Function of Each Type
private extension ProfileSingleSelectionListModel {
    
    func getMajorList() -> Observable<[String]> {
        return Observable
            .of(["전공1", "전공2", "전공3", "전공4"])
    }
    
    func getMBTIList() -> Observable<[String]> {
        
        if let url = Bundle.main.url(forResource: "WanF", withExtension: "plist") {
            let dictionary = NSDictionary(contentsOf: url)
            let items = dictionary?["MBTI"] as? Array<String> ?? []
            
            return Observable.of(items)
        }
        else {
            return Observable.of([])
        }
    }
    
    func saveMajor(_ data: String) -> Observable<Bool> {
        return Observable
            .just(data)
            .map {
                print($0)
                return true
            }
    }
    
    func saveMBTI(_ data: String) -> Observable<Bool> {
        return Observable
            .just(data)
            .map {
                print($0)
                return true
            }
    }
}

//MARK: - Type
enum ProfileSingleSelectionType {
    case major
    case MBTI
}
