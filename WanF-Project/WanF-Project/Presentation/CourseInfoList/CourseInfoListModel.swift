//
//  CourseInfoListModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/05/19.
//

import Foundation

import RxSwift

struct CourseInfoListModel {
    
    let network = CourseNetwork()
    
    // 모든 강의 조회
    func loadAllCourses() -> Single<Result<[CourseEntity], WanfError>> {
        return network.getAllCourse()
    }
    
    func getAllCoursesValue(_ result: Result<[CourseEntity], WanfError>) -> [CourseEntity]? {
        if case .success(let value) = result {
            return value
        }
        return nil
    }
    
    func getAllCoursesError(_ result: Result<[CourseEntity], WanfError>) -> Void? {
        if case .failure(let error) = result {
            
            print("ERROR: \(error)")
            return Void()
        }
        return nil
    }
}
