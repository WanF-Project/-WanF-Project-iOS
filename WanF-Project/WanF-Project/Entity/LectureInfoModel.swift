//
//  LectureInfoModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/11.
//

import Foundation

struct LectureInfoModel {
    let lectureName: String
    let professorName: String
}

extension LectureInfoModel {
    static let lectureInfoCellData = [
        LectureInfoModel(lectureName: "소프트웨어 캡스톤 디자인", professorName: "이승진"),
        LectureInfoModel(lectureName: "소프트웨어 캡스톤 디자인", professorName: "이승진"),
        LectureInfoModel(lectureName: "소프트웨어 캡스톤 디자인", professorName: "이승진"),
        LectureInfoModel(lectureName: "소프트웨어 캡스톤 디자인", professorName: "이승진")
    ]
}
