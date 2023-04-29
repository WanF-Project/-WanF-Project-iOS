//
//  ProfileContentModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/04/29.
//

import Foundation

import RxSwift

// TODO: - 서버 연결 시 재구현
struct ProfileContentModel {
    
    func loadProfile() -> Observable<Bool> {
        return Observable
            .just(true)
    }
    
    func getProfileValue(_ result: Bool) -> ProfileContent? {
        if !result {
            return nil
        }
        return ProfileContent(profileImage: "AppIcon", nickname: "원프", major: "IT융합자율학부 소프트웨어공학전공", entranceYear: "23학번", birth: "20살", gender: "여자", MBTI: "ENFP", personality: ["느긋함", "효율중시", "계획적", "꼼꼼함"], purpose: ["과탑", "친목", "앞자리"], contact: "WanF")
    }
    
    func getProfileError(_ result: Bool) -> Bool? {
        if result {
            return nil
        }
        return false
    }
    
}
