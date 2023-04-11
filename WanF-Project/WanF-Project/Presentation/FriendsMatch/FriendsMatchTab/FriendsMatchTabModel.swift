//
//  FriendsMatchTabModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/11.
//

import Foundation

import RxSwift

// TODO: - 서버 연결 시 재구현
struct FriendsMatchTabModel {
    
    func loadFriendsMatchList() -> Observable<Bool> {
        return Observable
            .just(true)
    }
    
    func getFriendsMatchListValue(_ result: Bool) -> [FriendsMatchListCellModel]? {
        if !result {
            return nil
        }
        return [
            FriendsMatchListCellModel(title: "원프에서 같이 수업 들을 사람 구해요!", lectureInfo: LectureInfoModel(lectureName: "소프트웨어 캡스톤 디자인", professorName: "이승진")),
            FriendsMatchListCellModel(title: "원프에서 같이 수업 들을 사람 구해요!", lectureInfo: LectureInfoModel(lectureName: "소프트웨어 캡스톤 디자인", professorName: "이승진")),
            FriendsMatchListCellModel(title: "원프에서 같이 수업 들을 사람 구해요!", lectureInfo: LectureInfoModel(lectureName: "소프트웨어 캡스톤 디자인", professorName: "이승진")),
            FriendsMatchListCellModel(title: "원프에서 같이 수업 들을 사람 구해요!", lectureInfo: LectureInfoModel(lectureName: "소프트웨어 캡스톤 디자인", professorName: "이승진"))
        ]
    }
    
    func getFriendsMatchListError(_ result: Bool) -> Bool? {
        if result {
            return nil
        }
        return false
    }
    
}
