//
//  FriendsMatchDetail.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/17.
//

import Foundation

struct FriendsMatchDetail {
    let title: String
    let content: String
    let lectureInfo: LectureInfoModel
}

extension FriendsMatchDetail {
    static let detailData = FriendsMatchDetail(title: "원프랑 같이 수업 들어요!", content: "WanF는 수업 친구 매칭 서비스로, 같이 수업을 듣고 정보를 공유할 친구를 찾을 수 있도록 장을 제공하는 성공회대학교 전용 플랫폼입니다.", lectureInfo: LectureInfoModel(lectureName: "소프트웨어 캡스톤 디자인", professorName: "이승진"))
}
